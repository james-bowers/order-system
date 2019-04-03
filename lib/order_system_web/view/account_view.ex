defmodule OrderSystemWeb.AccountView do
  use OrderSystemWeb, :view
  alias OrderSystem.Account
  alias OrderSystemWeb.View

  def render(nil, :account_balance, conn) do
    conn
    |> send_json(
      404,
      %View{
        content: nil,
        description: "The account could not be found."
      }
    )
  end

  def render(balance, :account_balance, conn) do
    conn
    |> send_json(
      200,
      %View{
        content: balance,
        description: "The account's current balance."
      }
    )
  end

  def render(account = %Account{}, :fetch, conn) do
    conn
    |> send_json(
      200,
      %View{
        content: Map.take(account, [:id, :title]),
        description: "A new account has been created."
      }
    )
  end

  def render({:error, :no_account_id_provided}, :new_account, conn) do
    conn
    |> send_json(
      400,
      %View{
        content: nil,
        description: "An account ID must be provided."
      }
    )
  end

  def render({:ok, account = %Account{}}, :new_account, conn) do
    render(account, :fetch, conn)
  end

  def render(result, :transfer_history, conn) do
    conn
    |> send_json(
      200,
      %View{
        content: result,
        description: "Transfer history for an account."
      }
    )
  end
end
