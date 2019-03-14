defmodule OrderSystem.ProductController do
  alias OrderSystem.{Repo, ProductModel}

  def create_product(%{quantity: _} = params) do
    ProductModel.create_product(params)
    |> Repo.transaction()
  end
end
