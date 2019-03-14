defmodule OrderSystemWeb do
  # Web logic in this namespace.

  def router do
    quote do
      import Plug.Conn

      def take_params(conn, params) do
        # TODO: String.to_atom opens memory issues, as atoms aren't garbage collected
        conn.params
        |> Map.take(params)
        |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
      end
    end
  end

  def view do
    quote do
      import Plug.Conn
      import OrderSystemWeb.View
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
