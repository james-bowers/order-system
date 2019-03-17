defmodule OrderSystemWeb.OrderRoute do
  use OrderSystemWeb, :router
  use Plug.Router

  alias OrderSystem.{Order, OrderModel, OrderController}
  alias OrderSystemWeb.OrderView

  plug(:match)
  plug(OrderSystemWeb.Plug.ValidPathId, ["id"])
  plug(:dispatch)

  @params ["items"]

  get "/:id" do
    conn
    |> take_params(["id"])
    |> format_as_struct(Order)
    |> OrderModel.retrieve_order()
    |> OrderView.render(:retrieve, conn)
  end

  post "/" do
    conn
    |> format_order_body()
    |> OrderController.create_order()
    |> OrderView.render(:new_order, conn)
  end

  defp format_order_body(conn) do
    conn
    |> take_params(@params)
    |> update_in([:items], &format_items/1)
  end

  defp format_items(items) do
    items
    |> Enum.map(fn item ->
      %{product_id: item["product_id"], quantity: item["quantity"]}
    end)
  end
end
