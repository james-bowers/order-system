defmodule OrderSystem.OrderModel do
  alias OrderSystem.{Repo, Order, ItemModel}

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
end
