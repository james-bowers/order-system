defmodule OrderSystemWeb.Controller.Account do
  use OrderSystemWeb, :controller

  alias OrderSystem.{Account, AccountModel}
  alias OrderSystemWeb.AccountView

  def new(conn) do
    account_params = %{title: conn.params["title"]}

    case AccountModel.create_account(account_params) do
      {:ok, result} -> AccountView.render(conn, :new_account, result)
      {:error, changeset} -> AccountView.render(conn, :error, changeset)
    end
  end

  def fetch(conn) do
    account = AccountModel.get_account!(account(conn))
    AccountView.render(conn, :fetch, account)
  end

  def fetch_transfer_history(conn) do
    transfer_history = AccountModel.transfer_history(account(conn))

    AccountView.render(conn, :transfer_history, transfer_history)
  end

  def fetch_sold_products(conn) do
    sold_products = AccountModel.retrieve_products_sold(account(conn), conn.assigns.options)

    AccountView.render(conn, :sold_products, sold_products)
  end

  defp account(conn) do
    %Account{id: account_id(conn)}
  end

  defp account_id(conn) do
    conn.params["account_id"]
  end
end
