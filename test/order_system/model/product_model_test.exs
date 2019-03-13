defmodule Test.OrderSystem.ProductModel do
  use ExUnit.Case
  use Test.OrderSystem.DataCase
  alias Ecto.Multi

  alias OrderSystem.{Product, ProductModel}
  @quantity 2
  @valid_attrs %{title: "A new product!", amount: 2000, quantity: @quantity}
  @product1_id "8ea46125-3d93-4858-bd14-c0de1f1a26cb"
  @empty_product_id "b22de4bf-b5c7-405b-81d9-aac8e901d1e0"

  test "create_product/1 with valid data creates a product with items" do
    multi =
      ProductModel.create_product(@valid_attrs)
      |> Ecto.Multi.to_list()

    assert [
             product: {:insert, changeset, []},
             items: {:run, _function}
           ] = multi

    assert changeset.valid?
    assert changeset.changes == %{amount: 2000, title: "A new product!"}
  end

  test "create_product/1 without title" do
    invalid_attrs = Map.delete(@valid_attrs, :title)

    assert [
             product: {:insert, changeset, []},
             items: {:run, _func}
           ] = ProductModel.create_product(invalid_attrs) |> Multi.to_list()

    assert changeset.valid? == false
    assert errors_on(changeset) == %{title: ["can't be blank"]}
  end

  test "get available quantity of a valid product id" do
    assert 3 == ProductModel.get_quantity(%Product{id: @product1_id}, :available)
  end

  test "get available quantity of an un-found product id" do
    assert 0 == ProductModel.get_quantity(%Product{id: @empty_product_id}, :available)
  end
end
