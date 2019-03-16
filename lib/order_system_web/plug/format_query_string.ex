defmodule OrderSystemWeb.Plug.FormatQueryString do
  import Plug.Conn

  @integer_option_keys ["page", "limit"]

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
    conn
    |> fetch_query_params()
    |> Map.fetch!(:query_params)
    |> Enum.map(&format_key_pair/1)
  end

  defp format_key_pair({key, value}) when key in @integer_option_keys do
    {String.to_existing_atom(key), String.to_integer(value)}
  end

  defp format_key_pair({key, value}) do
    {String.to_existing_atom(key), value}
  end
end
