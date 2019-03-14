defmodule OrderSystem.OrderModel do
  alias Ecto.Multi
  alias OrderSystem.{Repo, Item, Order}
  use OrderSystem.Query

  def create_order(order) do
    Multi.new()
    |> Multi.insert(:order, insert_order(order))
    |> Multi.merge(fn %{order: inserted_order} ->
      reserve_items(Map.put(order, :id, inserted_order.id))
    end)
  end

  def reserve_items(order) do
    order.items
    |> Enum.with_index()
    |> Enum.reduce(Multi.new(), fn {item, index}, multi ->
      query = reserve_item_query(item)

      reserve_item_key = reserve_item_key(index)
      validate_quantity_key = validate_quantity_key(index)

      multi
      |> Multi.update_all(reserve_item_key, query, set: [order_id: order.id])
      |> Multi.run(validate_quantity_key, fn _repo, changes ->
        {updated_records_count, _} = Map.get(changes, reserve_item_key)

        validate_reserved_item_quantity(updated_records_count, item)
      end)
    end)
  end

  defp reserve_item_key(index) do
    "reserve_item_#{index}"
  end

  defp validate_quantity_key(index) do
    "validate_quantity_#{index}"
  end

  defp validate_reserved_item_quantity(updated_records_count, item) do
    case updated_records_count == item.quantity do
      true -> {:ok, updated_records_count}
      false -> {:error, :insufficient_quantity}
    end
  end

  defp reserve_item_query(item) do
    items_to_reserve =
      from(i in Item,
        select: %{id: i.id},
        where: i.product_id == ^item.product_id and is_nil(i.order_id),
        limit: ^item.quantity
      )

    from(i in Item, join: s in subquery(items_to_reserve), on: i.id == s.id)
  end

  defp insert_order(order) do
    %Order{}
    |> Order.changeset(order)
  end

  def retrieve_order(%Order{} = order) do
    query =
      from(o in Order,
        where: o.id == ^order.id,
        inner_join: i in assoc(o, :item),
        inner_join: p in assoc(i, :product),
        select: %{title: p.title, amount: p.amount, item_id: i.id},
        order_by: o.inserted_at
      )

    Repo.all(query)
  end
end
