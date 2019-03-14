defmodule OrderSystemWeb.AccountView do
  use OrderSystemWeb, :view
  alias OrderSystem.Account
  alias OrderSystemWeb.View

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

  def render({:ok, account = %Account{}}, :new_account, conn) do
    render(account, :fetch, conn)
  end
end
