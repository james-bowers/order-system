defmodule OrderSystemWeb.ProductRoute do
  alias OrderSystem.ProductController
  alias OrderSystemWeb.{ProductView}
  use OrderSystemWeb, :router

  use Plug.Router
  plug(:match)
  plug(:dispatch)

  @params ["quantity", "amount", "title"]

  post "/" do
    conn
    |> take_params(@params)
    |> ProductController.create_product()
    |> ProductView.render(:new_product, conn)
  end
end
