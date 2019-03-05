defmodule OrderSystem.ProductModel do
  alias OrderSystem.{Repo, ItemModel, Product}

  def create_product(%{quantity: _} = params) do
    Repo.transaction(fn ->
      with {:ok, product} <- insert_product(params),
           {inserted_items, _} <- insert_items(params, product) do
        {product, inserted_items}
      else
        {:error, changeset} -> Repo.rollback(changeset)
      end
    end)
  end

  defp insert_product(params) do
    %Product{}
    |> Product.changeset(params)
    |> Repo.insert()
  end

  defp insert_items(params, product) do
    ItemModel.create_items(
      %{product_id: product.id},
      params.quantity
    )
  end
end
