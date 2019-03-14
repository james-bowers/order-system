defmodule Test.OrderSystem.RefundController do
  use Test.OrderSystem.DataCase

  alias OrderSystem.RefundController

  @valid_refund_attrs %{
    order_id: "b03f40b3-5aa8-40f4-92c0-e0bf9d723c3c",
    amount: -2000,
    account_id: "7f68c8ee-882b-4512-bd73-a7c2147e5f77"
  }

  test "refund an order" do
    assert {:ok,
            %{
              refund: refund,
              transfer: transfer
            }} = RefundController.create_refund(@valid_refund_attrs)

    assert refund.order_id == @valid_refund_attrs.order_id
    assert transfer.id == refund.transfer_id
    assert transfer.amount == @valid_refund_attrs.amount
  end
end
