defmodule Test.OrderSystem.OrderModel do
  use ExUnit.Case
  use Test.OrderSystem.DataCase

  alias OrderSystem.{OrderModel, ItemModel}

  test "registers an order" do
    {product1_id, _} = Test.ProductFixture.create_product(%{quantity: 10})
    {product2_id, _} = Test.ProductFixture.create_product(%{quantity: 15})

    order = %{
      items: [
        %{
          product_id: product1_id,
          quantity: 3
        },
        %{
          product_id: product2_id,
          quantity: 2
        }
      ]
    }

    OrderModel.create_order(order)

    assert 7 == ItemModel.get_quantity(product1_id, :available)
    assert 13 == ItemModel.get_quantity(product2_id, :available)
  end
end
