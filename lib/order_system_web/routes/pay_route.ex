defmodule OrderSystemWeb.PayRoute do
  use OrderSystemWeb, :router
  use Plug.Router
  use Plug.ErrorHandler

  alias OrderSystem.PaymentController
  alias OrderSystemWeb.{ErrorView, PaymentView}

  plug(:match)
  plug(:dispatch)

  @params ["transfer_to", "order_id"]

  post "/" do
    conn
    |> format_payment_body()
    |> PaymentController.pay()
    |> PaymentView.render(:pay_order, conn)
  end

  defp format_payment_body(conn) do
    conn
    |> take_params(@params)
    |> update_in([:transfer_to], &format_transfers/1)
  end

  defp format_transfers(transfers) do
    transfers
    |> Enum.map(fn transfer ->
      %{account_id: transfer["account_id"], amount: transfer["amount"]}
    end)
  end

  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    ErrorView.render(conn, :invalid_id)
  end
end
