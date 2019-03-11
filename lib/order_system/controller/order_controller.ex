defmodule OrderSystem.OrderController do
  alias OrderSystem.{Repo, OrderModel}

  def create_order(order) do
    OrderModel.create_order(order)
    |> Repo.transaction()
  end
end
