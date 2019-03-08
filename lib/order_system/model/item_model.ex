defmodule OrderSystem.ItemModel do
  use OrderSystem.Query
  alias OrderSystem.{Repo, Item}

  def create_items(params \\ %{}, quantity) do
    item = Item.changeset(%Item{}, params)

    Repo.insert_all(Item, List.duplicate(item.changes, quantity))
  end

  def get_quantity(%Item{} = item, :available) do
    query =
      from(i in Item,
        where: is_nil(i.order_id) and i.product_id == ^item.product_id,
        select: count()
      )

    Repo.one(query)
  end

  def reserve_items(order) do
    order.items
    |> Enum.reduce_while({:ok, 0}, fn item, {:ok, total_inserted} ->
      case reserve_item(order, item) do
        {:ok, items_inserted} ->
          {:cont, {:ok, total_inserted + items_inserted}}

        {:error, reason} ->
          {:halt, {:error, reason}}
      end
    end)
  end

  defp reserve_item(order, item) do
    items_to_reserve =
      from(i in Item,
        select: %{id: i.id},
        where: i.product_id == ^item.product_id and is_nil(i.order_id),
        limit: ^item.quantity
      )

    from(i in Item, join: s in subquery(items_to_reserve), on: i.id == s.id)
    |> Repo.update_all(set: [order_id: order.id])
    |> validate_update(item)
  end

  defp validate_update({quantity_updated, nil}, item) do
    case item.quantity == quantity_updated do
      true -> {:ok, quantity_updated}
      false -> {:error, :not_all_updated}
    end
  end
end
