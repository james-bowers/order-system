defmodule OrderSystem.ProductModel do
  import Ecto.Query, warn: false
  alias OrderSystem.{Repo, Product, ItemModel}

  def create_product(%{quantity: quantity, title: title, amount: amount}) do
    Repo.transaction(fn ->
      attrs = %{title: title, amount: amount}

      product =
        %Product{}
        |> Product.changeset(attrs)
        |> Repo.insert!()

      {inserted_items, _} =
        ItemModel.create_items!(
          %{product_id: product.id, available: ItemModel.available()},
          quantity
        )

      {product.id, inserted_items}
    end)
  end
end
