defmodule Test.OrderSystem.PayoutModel do
  use ExUnit.Case
  use Test.OrderSystem.DataCase

  alias OrderSystem.{PayoutModel, TransferModel}

  test "logs a payout in the transfer table" do
    account1 = Test.AccountFixture.create_account()
    valid_attrs = %{amount: -5000, account_id: account1.id, stripe_transfer_id: "trans_12345"}
    {:ok, payout} = PayoutModel.create_payout(valid_attrs)

    assert TransferModel.get_transfer!(payout.transfer_id).amount == -5000
    assert TransferModel.get_balance!(account1.id) == -5000
  end
end
