defmodule Test.OrderSystem.PayoutController do
  use Test.OrderSystem.DataCase
  alias OrderSystem.PayoutController

  @account1_id "7f68c8ee-882b-4512-bd73-a7c2147e5f77"
  @valid_attrs %{
    stripe_transfer_id: "stripe_transfer_1234",
    amount: -3200,
    account_id: @account1_id
  }

  test "insert a payout" do
    assert {:ok, %{payout: payout, transfer: transfer}} =
             PayoutController.create_payout(@valid_attrs)

    assert payout.transfer_id == transfer.id
    assert transfer.account_id == @account1_id
    assert transfer.amount == -3200
  end
end
