defmodule Test.OrderSystem.TransferModel do
  use ExUnit.Case
  use Test.OrderSystem.DataCase

  alias OrderSystem.{TransferModel, Account}
  alias Ecto.Multi

  @account3_id "eacb49e9-221e-488e-9e6d-a6fb529d5f4b"

  @valid_transfer_attrs %{amount: 100, account_id: @account3_id}

  test "create_transfer/1" do
    assert [
             transfer: {:insert, changeset, []}
           ] = TransferModel.create_transfer(@valid_transfer_attrs) |> Multi.to_list()

    assert changeset.valid? == true
    assert changeset.changes == @valid_transfer_attrs
  end

  test "get account balance" do
    assert TransferModel.get_balance(%Account{id: @account3_id}) == 2000
  end
end
