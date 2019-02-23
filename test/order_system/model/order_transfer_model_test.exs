defmodule Test.OrderSystem.OrderTransferModel do
  use ExUnit.Case
  use Test.OrderSystem.DataCase

  alias OrderSystem.{OrderTransferModel}

  test "registers a transfer for a given order (part of the create order db transaction)" do
    account1 = Test.AccountFixture.create_account()
    account2 = Test.AccountFixture.create_account()

    {product1_id, _quantity} = Test.ProductFixture.create_product()

    order1 =
      Test.OrderFixture.create_order(%{
        items: [
          %{
            product_id: product1_id,
            quantity: 5
          }
        ]
      })

    pay_order = %{
      order_id: order1.id,
      transfer_to: [
        %{
          account_id: account1.id,
          amount: 500
        },
        %{
          account_id: account2.id,
          amount: 300
        }
      ]
    }

    {:ok, order_transfer} = OrderTransferModel.create_order_transfer(pay_order)

    assert length(order_transfer) == 2
  end
end
