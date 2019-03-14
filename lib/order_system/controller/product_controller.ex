defmodule OrderSystem.ProductController do
  alias OrderSystem.{Repo, Product, ProductModel}

  def create_product(%{quantity: _} = params) do
    ProductModel.create_product(params)
    |> Repo.transaction()
  end

  def get_quantity(%{product_id: product_id}, :available) do
    ProductModel.get_quantity(%Product{id: product_id}, :available)
  end
end
