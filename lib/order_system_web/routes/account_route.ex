defmodule OrderSystemWeb.AccountRoute do
  use OrderSystemWeb, :router
  use Plug.Router
  alias OrderSystem.{Account, AccountModel}
  alias OrderSystemWeb.AccountView

  plug(:match)
  plug(OrderSystemWeb.Plug.ValidPathId, ["id"])
  plug(:dispatch)

  @params ["title"]

  post "/" do
    conn
    |> take_params(@params)
    |> AccountModel.create_account()
    |> AccountView.render(:new_account, conn)
  end

  get "/:id/transfers" do
    conn
    |> take_params(["id"])
    |> format_as_struct(Account)
    |> AccountModel.transfer_history()
    |> AccountView.render(:transfer_history, conn)
  end
end
