defmodule Test.OrderFixture do
  alias OrderSystem.OrderModel

  def create_order(%{items: items}) do
    order = %{
      items: items
    }

    {:ok, order} = OrderModel.create_order(order)
    order
  end
end
