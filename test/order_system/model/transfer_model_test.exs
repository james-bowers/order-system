defmodule Test.OrderSystem.TransferModel do
  use ExUnit.Case
  use Test.OrderSystem.DataCase

  alias OrderSystem.{TransferModel, Account}

  test "get account balance" do
    account4_id = "437d0472-4d46-4b9c-a035-b8eed120aa62"
    Test.TransferFixture.create_transfer!(%{account_id: account4_id, amount: 2000})
    Test.TransferFixture.create_transfer!(%{account_id: account4_id, amount: 2000})
    Test.TransferFixture.create_transfer!(%{account_id: account4_id, amount: -500})
    Test.TransferFixture.create_transfer!(%{account_id: account4_id, amount: 3000})
    Test.TransferFixture.create_transfer!(%{account_id: account4_id, amount: -2000})

    assert TransferModel.get_balance(%Account{id: account4_id}) == 4500
  end
end
