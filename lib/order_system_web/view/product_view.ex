defmodule OrderSystemWeb.ProductView do
  use OrderSystemWeb, :view
  alias OrderSystem.Product

  def render(conn, :new_product, {%Product{} = product, _available_items}) do
    conn
    |> send_json(200, Map.take(product, [:id, :title, :quantity]))
  end

  def render(conn, :error, %Ecto.Changeset{} = changeset) do
    conn
    |> send_json(400, format_changeset(changeset))
  end
end
