defmodule Test.OrderSystem.OrderModel do
  use ExUnit.Case
  use Test.OrderSystem.DataCase

  alias OrderSystem.{Order, OrderModel, Item, ItemModel}

  @product1_id "8ea46125-3d93-4858-bd14-c0de1f1a26cb"

  test "registers an order" do
    order = %{
      items: [
        %{
          product_id: @product1_id,
          quantity: 2
        }
      ]
    }

    {:ok, {_order, 2}} = OrderModel.create_order(order)

    assert 1 == ItemModel.get_quantity(%Item{product_id: @product1_id}, :available)
  end

  test "prevents oversell & rolls back" do
    order = %{
      items: [
        %{
          product_id: @product1_id,
          quantity: 4
        }
      ]
    }

    {:error, :not_all_updated} = OrderModel.create_order(order)

    assert 3 == ItemModel.get_quantity(%Item{product_id: @product1_id}, :available)
  end

  test "get items in an order" do
    items = OrderModel.retrieve_order(%Order{id: "b03f40b3-5aa8-40f4-92c0-e0bf9d723c3c"})

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
