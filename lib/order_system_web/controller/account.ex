defmodule OrderSystemWeb.Controller.Account do
  use OrderSystemWeb, :controller
  alias OrderSystem.AccountModel
  alias OrderSystemWeb.AccountView

  def new (conn) do
    account_params = %{title: conn.params["title"]}
    case AccountModel.create_account(account_params) do
      {:ok, result} -> AccountView.render(conn, :new_account, result)
      {:error, changeset} -> AccountView.render(conn, :error, changeset)
    end
  end
end