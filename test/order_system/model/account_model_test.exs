defmodule Test.OrderSystem.AccountModel do
  use ExUnit.Case
  use Test.OrderSystem.DataCase

  alias OrderSystem.{Account, AccountModel}

  @valid_attrs %{title: "James' account"}

  test "create_account/1 with valid data creates an account" do
    assert {:ok, %Account{} = account} = AccountModel.create_account(@valid_attrs)
    assert account.title == "James' account"
    assert account.stripe_account_id == nil
  end

  test "retrieve products sold by account" do
    results =
      AccountModel.retrieve_products_sold(%Account{id: "7f68c8ee-882b-4512-bd73-a7c2147e5f77"})

    assert results == [
             %{
               title: "A seed data product title",
               product_id: "8ea46125-3d93-4858-bd14-c0de1f1a26cb"
             }
           ]
  end

  test "an account's transfer history" do
    transfer_history =
      AccountModel.transfer_history(%Account{id: "eacb49e9-221e-488e-9e6d-a6fb529d5f4b"})

    assert transfer_history == [
             %{amount: 1000, transfered_at: ~N[2019-02-22 16:59:38]},
             %{amount: 3000, transfered_at: ~N[2019-02-22 16:59:39]},
             %{amount: -2000, transfered_at: ~N[2019-02-22 16:59:40]}
           ]
  end
end
