defmodule Test.OrderSystem.OrderController do
  use Test.OrderSystem.DataCase

  alias OrderSystem.{Product, ProductModel, OrderController}

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

    assert {:ok,
            %{
              order: order,
              reserve_items: {2, nil}
            }} = OrderController.create_order(order)

    assert 1 == ProductModel.get_quantity(%Product{id: @product1_id}, :available)
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

    assert {:error, :validate_quantity, :insufficient_quantity,
            %{
              order: order,
              reserve_items: {3, nil}
            }} = OrderController.create_order(order)

    assert 3 == ProductModel.get_quantity(%Product{id: @product1_id}, :available)
  end
end
