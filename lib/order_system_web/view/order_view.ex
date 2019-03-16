defmodule OrderSystemWeb.OrderView do
  use OrderSystemWeb, :view
  alias OrderSystem.Order
  alias OrderSystemWeb.View

  def render({:ok, %{order: order = %Order{}}}, :new_order, conn) do
    conn
    |> send_json(
      200,
      %View{
        content: Map.take(order, [:id]),
        description: "A new order has been registered."
      }
    )
  end

  def render(
        {:error, _failed_item_key, :insufficient_quantity, _change_progress},
        :new_order,
        conn
      ) do
    conn
    |> send_json(
      400,
      %View{
        content: nil,
        description: "There are not enough available items to process your request."
      }
    )
  end
end
