defmodule OrderSystem.ProductModel do
  alias OrderSystem.{Item, Product}
  alias Ecto.Multi

  def create_product(%{quantity: _} = params) do
    Multi.new()
    |> Multi.insert(:product, insert_product_changeset(params))
    |> Multi.run(:items, fn repo, changes -> insert_all_items(repo, params, changes) end)
  end

  defp insert_product_changeset(params) do
    %Product{}
    |> Product.changeset(params)
  end

  defp insert_all_items(repo, params, %{product: product}) do
    case repo.insert_all(Item, items(product, params)) do
      {inserted, nil} -> {:ok, inserted}
      {:error, changeset} -> {:error, changeset}
    end
  end

  defp items(%Product{} = product, params) do
    List.duplicate(%{product_id: product.id}, params.quantity)
  end
end
