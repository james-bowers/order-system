defmodule OrderSystem.RefundModel do
  alias OrderSystem.{Repo, Refund, TransferModel}
  import Ecto.Query, only: [from: 2]

  def create_refund(%{order_id: _, amount: _, account_id: _} = attrs) do
    Repo.transaction(fn ->
      transfer_attrs = insert_transfer!(attrs)

      {:ok, refund} =
        %Refund{}
        |> Refund.changeset(transfer_attrs)
        |> Repo.insert()

      refund
    end)
  end

  defp insert_transfer!(transfer_attrs) do
    {:ok, transfer} = TransferModel.create_transfer(transfer_attrs)

    transfer_attrs
    |> Map.put(:transfer_id, transfer.id)
  end

  def retrieve_refund_history(order_id) do
    query =
      from(r in Refund,
        where: r.order_id == ^order_id,
        inner_join: t in assoc(r, :transfer),
        select: %{
          refunded_at: r.inserted_at,
          amount: t.amount,
          transfer_id: r.transfer_id,
          order_id: r.order_id
        }
      )

    Repo.all(query)
  end
end
