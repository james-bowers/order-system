defmodule OrderSystem.OrderModel do
  alias OrderSystem.{Repo, Order, ItemModel}
  use OrderSystem.Query

  def create_order(order) do
    Repo.transaction(fn ->
      order
      |> insert_order!()
      |> ItemModel.reserve_items!()
    end)
  end

  defp insert_order!(order) do
    inserted_order =
      %Order{}
      |> Order.changeset(%{})
      |> Repo.insert!()

    order
    |> Map.put(:id, inserted_order.id)
  end

  def retrieve_order(order_id) do
    query =
      from(o in Order,
        where: o.id == ^order_id,
        inner_join: i in assoc(o, :item),
        inner_join: p in assoc(i, :product),
        select: %{title: p.title, amount: p.amount, item_id: i.id},
        order_by: o.inserted_at
      )

    Repo.all(query)
  end
end
