defmodule OrderSystemWeb.AccountRoute do
  use OrderSystemWeb, :router
  use Plug.Router
  alias OrderSystem.AccountModel
  alias OrderSystemWeb.AccountView

  plug(:match)
  plug(:dispatch)

  @params ["title"]

  post "/" do
    conn
    |> take_params(@params)
    |> AccountModel.create_account()
    |> AccountView.render(:new_account, conn)
  end
end
