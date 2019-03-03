defmodule OrderSystemWeb.Plug.ValidPathId do
  import Plug.Conn
  alias OrderSystemWeb.ErrorView

  def init(opts), do: opts

  def call(conn, path_ids) do
    case has_valid_ids?(conn, path_ids) do
      true ->
        conn

      false ->
        conn
        |> ErrorView.render(:invalid_id)
        |> halt()
    end
  end

  defp has_valid_ids?(conn, path_ids) do
    conn.path_params
    |> Map.take(path_ids)
    |> Enum.map(fn {_key, value} ->
      case Ecto.UUID.cast(value) do
        {:ok, _} -> true
        :error -> false
      end
    end)
    |> Enum.all?()
  end
end
