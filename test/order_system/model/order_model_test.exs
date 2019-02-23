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

  test "get items in an order" do
    items = OrderModel.retrieve_order("b03f40b3-5aa8-40f4-92c0-e0bf9d723c3c")

    assert items == [
             %{
               amount: 3000,
               item_id: "b4c0fb72-e4b0-47fb-958f-20c0a831a2dc",
               title: "A seed data product title"
             },
             %{
               amount: 3000,
               item_id: "9c3be15f-5051-416d-a503-1fddf9bff65c",
               title: "A seed data product title"
             }
           ]
  end
end
