defmodule Test.OrderSystem.OrderTransferModel do
  use ExUnit.Case
  use Test.OrderSystem.DataCase

  alias OrderSystem.{OrderTransferModel}

  @order1_id "b03f40b3-5aa8-40f4-92c0-e0bf9d723c3c"
  @account1_id "7f68c8ee-882b-4512-bd73-a7c2147e5f77"
  @account2_id "cde9abbd-bcfd-46d1-a6ed-aec6d2c712ae"

  test "registers a transfer for a given order (part of the create order db transaction)" do
    pay_order = %{
      order_id: @order1_id,
      transfer_to: [
        %{
          account_id: @account1_id,
          amount: 500
        },
        %{
          account_id: @account2_id,
          amount: 300
        }
      ]
    }

    {:ok, order_transfer} = OrderTransferModel.create_order_transfer(pay_order)

    assert length(order_transfer) == 2
  end
end
