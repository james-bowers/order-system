defmodule OrderSystemWeb.AccountView do
  use OrderSystemWeb, :view
  alias OrderSystem.Account

  def render(conn, :fetch, content = %Account{}) do
    conn
    |> send_json(200, Map.take(content, [:id, :title]))
  end

  def render(conn, :new_account, content = %Account{}) do
    render(conn, :fetch, content)
  end

  def render(conn, :transfer_balance, balance) do
    conn
    |> send_json(200, %{balance: balance})
  end

  def render(conn, :transfer_history, transfer_history) do
    conn
    |> send_json(200, %{history: transfer_history})
  end

  def render(conn, :sold_products, sold_products) do
    conn
    |> send_json(200, %{sold_products: sold_products})
  end
end
