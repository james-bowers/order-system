defmodule OrderSystem.ProductModel do
  alias OrderSystem.{Repo, ItemModel, Product}

  def create_product(%{quantity: quantity, title: title, amount: amount} = params)
      when is_binary(title) and is_integer(amount) do
    Repo.transaction(fn ->
      attrs = Map.take(params, [:title, :amount])

      product =
        %Product{}
        |> Product.changeset(attrs)
        |> Repo.insert!()

      {inserted_items, _} =
        ItemModel.create_items!(
          %{product_id: product.id},
          quantity
        )

      {product.id, inserted_items}
    end)
  end
end
