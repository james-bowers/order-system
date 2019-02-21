defmodule Test.OrderSystem.TransferModel do
  use ExUnit.Case
  use Test.OrderSystem.DataCase

  alias OrderSystem.{TransferModel}

  test "get account balance" do
    account = Test.AccountFixture.create_account()
    Test.TransferFixture.create_transfer!(%{account_id: account.id, amount: 2000})
    Test.TransferFixture.create_transfer!(%{account_id: account.id, amount: 2000})
    Test.TransferFixture.create_transfer!(%{account_id: account.id, amount: -500})
    Test.TransferFixture.create_transfer!(%{account_id: account.id, amount: 3000})
    Test.TransferFixture.create_transfer!(%{account_id: account.id, amount: -2000})

    assert TransferModel.get_balance!(account.id) == 4500
  end
end
