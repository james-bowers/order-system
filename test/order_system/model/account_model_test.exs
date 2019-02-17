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
end
