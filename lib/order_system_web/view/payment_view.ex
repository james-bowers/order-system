defmodule OrderSystemWeb.PaymentView do
  use OrderSystemWeb, :view
  alias OrderSystemWeb.View

  def render({:ok, _changes}, :pay_order, conn) do
    conn
    |> send_json(
      200,
      %View{
        content: nil,
        description: "Order payment completed."
      }
    )
  end
end
