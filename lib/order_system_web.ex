defmodule OrderSystemWeb do
  # Web logic in this namespace.

  def controller do
    quote do
      import Plug.Conn
    end
  end

  def view do
    quote do
      import Plug.Conn

      defp send_json(conn, status, content) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(status, Poison.encode!(content))
      end

      defp format_changeset(changeset) do
        Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
          Enum.reduce(opts, msg, fn {key, value}, acc ->
            String.replace(acc, "%{#{key}}", to_string(value))
          end)
        end)
      end
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
