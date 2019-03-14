defmodule OrderSystemWeb.ProductRoute do
  alias OrderSystem.ProductController
  alias OrderSystemWeb.{ProductView}
  use OrderSystemWeb, :router

  use Plug.Router
  plug(:match)
  plug(OrderSystemWeb.Plug.ValidPathId, ["product_id"])
  plug(:dispatch)

  @params ["quantity", "amount", "title"]

  post "/" do
    conn
    |> take_params(@params)
    |> ProductController.create_product()
    |> ProductView.render(:new_product, conn)
  end

  get "/:product_id/available" do
    conn
    |> take_params(["product_id"])
    |> ProductController.get_quantity(:available)
    |> ProductView.render(:available, conn)
  end
end
