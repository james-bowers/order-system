defmodule OrderSystemWeb.ProductRoute do
  alias OrderSystem.{Product, ProductModel, ProductController}
  alias OrderSystemWeb.{ProductView}
  use OrderSystemWeb, :router

  use Plug.Router
  plug(:match)
  plug(OrderSystemWeb.Plug.ValidPathId, ["id"])
  plug(:dispatch)

  @params ["quantity", "amount", "title"]

  post "/" do
    conn
    |> take_params(@params)
    |> ProductController.create_product()
    |> ProductView.render(:new_product, conn)
  end

  get "/:id/available" do
    conn
    |> take_params(["id"])
    |> format_as_struct(Product)
    |> ProductModel.get_quantity(:available)
    |> ProductView.render(:available, conn)
  end
end
