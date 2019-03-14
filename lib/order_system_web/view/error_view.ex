defmodule OrderSystemWeb.ErrorView do
  use OrderSystemWeb, :view
  alias OrderSystemWeb.View

  def render(conn, :invalid_id) do
    conn
    |> send_json(400, %View{description: "An invalid ID was provided.", content: nil})
  end

  def render(conn, :error, %Ecto.Changeset{} = changeset) do
    conn
    |> send_json(400, format_changeset(changeset))
  end
end
