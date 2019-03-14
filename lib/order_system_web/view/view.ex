defmodule OrderSystemWeb.View do
  import Plug.Conn

  @enforce_keys [:description, :content]
  defstruct [:description, :content]

  def send_json(conn, status, %__MODULE__{} = content) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Poison.encode!(content))
  end

  def format_changeset(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
