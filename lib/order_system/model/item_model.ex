defmodule OrderSystem.ItemModel do
  import Ecto.Query
  alias OrderSystem.{Repo, Item}

  def create_items!(params \\ %{}, quantity) do
    item = Item.changeset(%Item{}, params)

    Repo.insert_all(Item, List.duplicate(item.changes, quantity))
  end

  def get_quantity(product_id, :available) do
    query =
      from(i in Item,
        where: is_nil(i.order_id) and i.product_id == ^product_id,
        select: count()
      )

    Repo.one(query)
  end

  def reserve_items!(order) do
    order.items
    |> Enum.map(fn item -> reserve_item!(order, item) end)

    order
  end

  defp reserve_item!(order, item) do
    items_to_reserve =
      from(i in Item,
        select: i.id,
        where: i.product_id == ^item.product_id,
        limit: ^item.quantity
      )

    from(i in Item, join: s in subquery(items_to_reserve), on: i.id == s.id)
    |> Repo.update_all(set: [order_id: order.id])
  end
end
