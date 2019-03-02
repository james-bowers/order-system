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
      import OrderSystemWeb.View
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
