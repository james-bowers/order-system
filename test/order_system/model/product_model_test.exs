defmodule Test.OrderSystem.ProductModel do
  use ExUnit.Case
  use Test.OrderSystem.DataCase

  alias OrderSystem.{ProductModel, Item, ItemModel}
  @quantity 40
  @valid_attrs %{title: "A new product!", amount: 2000, quantity: @quantity}

  test "create_product/1 with valid data creates a product with items" do
    {:ok, {product, @quantity}} = ProductModel.create_product(@valid_attrs)

    assert @quantity == ItemModel.get_quantity(%Item{product_id: product.id}, :available)
  end
end
