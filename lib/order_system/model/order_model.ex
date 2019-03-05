defmodule OrderSystem.OrderModel do
  alias OrderSystem.{Repo, Order, ItemModel}
  use OrderSystem.Query

  def create_order(order) do
    Repo.transaction(fn ->
      with {:ok, order} <- insert_order(order),
           {:ok, _quantity} <- ItemModel.reserve_items(order) do
        order
      else
        {:error, error} -> Repo.rollback(error)
      end
    end)
  end

  defp insert_order(order) do
    insert_result =
      %Order{}
      |> Order.changeset(%{})
      |> Repo.insert()

    case insert_result do
      {:ok, inserted_order} -> {:ok, Map.put(order, :id, inserted_order.id)}
      {:error, changeset} -> {:error, changeset}
    end
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
