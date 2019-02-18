defmodule Test.ProductFixture do
  alias OrderSystem.ProductModel

  @default_product_attrs %{quantity: 50, title: "A great product title", amount: 3500}

  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(@default_product_attrs)
      |> ProductModel.create_product()

    product
  end
end
