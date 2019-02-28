defmodule OrderSystemWeb.AccountView do
  use OrderSystemWeb, :view

  def render(conn, :new_account, content) do
    conn
    |> send_json(200, Map.take(content, [:id, :title]))  
  end

  def render(conn, :error, %Ecto.Changeset{} = changeset) do
    conn
    |> send_json(400, format_changeset(changeset))
  end
end