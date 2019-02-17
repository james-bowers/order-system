defmodule Test.AccountFixture do
  alias OrderSystem.AccountModel

  @valid_attrs %{title: "a title for the account"}

  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(@valid_attrs)
      |> AccountModel.create_account()

    account
  end
end