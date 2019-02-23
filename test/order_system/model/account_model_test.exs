defmodule Test.OrderSystem.AccountModel do
  use ExUnit.Case
  use Test.OrderSystem.DataCase

  alias OrderSystem.{Account, AccountModel}

  @valid_attrs %{title: "James' account"}
  @invalid_attrs %{no_title_key: "James' account"}

  test "create_account/1 with valid data creates an account" do
    assert {:ok, %Account{} = account} = AccountModel.create_account(@valid_attrs)
    assert account.title == "James' account"
    assert account.stripe_account_id == nil
  end

  test "create_account/1 with invalid data, does not create an account" do
    assert {:error, changeset} = AccountModel.create_account(@invalid_attrs)
    assert "can't be blank" in errors_on(changeset).title
  end

  test "retrieve products sold by account" do
    results = AccountModel.retrieve_products_sold("7f68c8ee-882b-4512-bd73-a7c2147e5f77")

    assert results == [
             %{
               title: "A seed data product title",
               product_id: "8ea46125-3d93-4858-bd14-c0de1f1a26cb"
             }
           ]
  end
end
