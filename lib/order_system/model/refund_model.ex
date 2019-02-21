defmodule OrderSystem.RefundModel do
  alias OrderSystem.{Repo, Refund, TransferModel}

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
end
