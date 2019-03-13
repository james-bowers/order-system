defmodule OrderSystem.RefundModel do
  alias OrderSystem.{Repo, Refund, Order}
  alias Ecto.Multi
  use OrderSystem.Query

  def create_refund(%{order_id: _, transfer_id: _} = attrs) do
    Multi.new()
    |> Multi.insert(:refund, refund_changeset(attrs))
  end

  defp refund_changeset(attrs) do
    %Refund{}
    |> Refund.changeset(attrs)
  end

  def retrieve_refund_history(%Order{} = order) do
    query =
      from(r in Refund,
        where: r.order_id == ^order.id,
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
