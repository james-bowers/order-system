defmodule OrderSystemWeb.ProductView do
  use OrderSystemWeb, :view
  alias OrderSystemWeb.{View}
  alias OrderSystem.Product

  def render({:ok, %{items: quantity, product: %Product{} = product}}, :new_product, conn) do
    conn
    |> send_json(200, %View{
      content: Map.take(product, [:id, :title, :quantity]),
      description: "#{quantity} items have been created for #{product.title}"
    })
  end

  def render(quantity, :available, conn) do
    conn
    |> send_json(200, %View{
      content: quantity,
      description: "Quantity of this product available for purchase."
    })
  end

  def render({:error, action, changeset, _}, :new_product, conn) do
    conn
    |> send_json(400, %View{
      content: %{
        action: action,
        changeset: format_changeset(changeset)
      },
      description: "Sorry, we have not created your product, as the request made was invalid."
    })
  end
end
