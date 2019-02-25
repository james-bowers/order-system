defmodule OrderSystem.Plug.FormatRequest do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> assign_query_string()
  end

  defp assign_query_string(conn) do
    conn
    |> assign(:options, parse_query_string(conn))
  end

  defp parse_query_string(conn) do
    conn.query_string
    |> Plug.Conn.Query.decode()
    |> Map.to_list()
    |> Enum.map(fn {key, value} -> {String.to_atom(key), value} end)
  end
end
