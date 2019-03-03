defmodule OrderSystemWeb.ErrorView do
  use OrderSystemWeb, :view

  def render(conn, :invalid_id) do
    conn
    |> send_json(400, %{error: "Invalid Id"})
  end

  def render(conn, :error, %Ecto.Changeset{} = changeset) do
    conn
    |> send_json(400, format_changeset(changeset))
  end
end
