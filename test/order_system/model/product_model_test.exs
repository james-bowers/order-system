defmodule Test.OrderSystem.ProductModel do
  use ExUnit.Case
  use Test.OrderSystem.DataCase
  alias Ecto.Multi

  alias OrderSystem.{ProductModel}
  @quantity 2
  @valid_attrs %{title: "A new product!", amount: 2000, quantity: @quantity}

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
end
