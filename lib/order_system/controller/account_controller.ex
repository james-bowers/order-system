defmodule OrderSystem.AccountController do
  alias OrderSystem.{Account, AccountModel}

  def get_account(%Account{} = account), do: AccountModel.get_account(account)

  def create_account(attrs), do: AccountModel.create_account(attrs)
end
