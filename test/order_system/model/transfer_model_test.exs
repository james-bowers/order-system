defmodule Test.OrderSystem.TransferModel do
  use ExUnit.Case
  use Test.OrderSystem.DataCase

  alias OrderSystem.{TransferModel, Account}

  @account3_id "eacb49e9-221e-488e-9e6d-a6fb529d5f4b"

  test "get account balance" do
    assert TransferModel.get_balance(%Account{id: @account3_id}) == 2000
  end
end
