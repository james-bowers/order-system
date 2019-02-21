defmodule Test.OrderSystem.RefundModel do
  use ExUnit.Case
  use Test.OrderSystem.DataCase

  alias OrderSystem.{RefundModel, TransferModel}

  test "refund an order" do
    account1 = Test.AccountFixture.create_account()

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

    valid_attrs = %{order_id: order1.id, amount: -2000, account_id: account1.id}
    {:ok, result} = RefundModel.create_refund(valid_attrs)

    assert Map.has_key?(result, :id)
    assert Map.has_key?(result, :order_id)
    assert Map.has_key?(result, :transfer_id)
    assert TransferModel.get_transfer!(result.transfer_id).amount == -2000
  end
end
