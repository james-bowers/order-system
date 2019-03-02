defmodule OrderSystemWeb.Controller.Product do
  use OrderSystemWeb, :controller

  alias OrderSystem.{Product, ProductModel}
  alias OrderSystemWeb.ProductView

  @params ["quantity", "amount", "title"]

  def new(conn) do
    product_params = take_params(conn, @params)

    case ProductModel.create_product(product_params) do
      {:ok, product} -> ProductView.render(conn, :new_product, product)
      {:error, changeset} -> ProductView.render(conn, :error, changeset)
    end
  end
end
