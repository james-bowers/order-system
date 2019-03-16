defmodule OrderSystemWeb.OrderRoute do
  use OrderSystemWeb, :router
  use Plug.Router

  alias OrderSystem.OrderController
  alias OrderSystemWeb.OrderView

  plug(:match)
  plug(:dispatch)

  @params ["items"]

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
