defmodule OrderSystem.RefundController do
  alias OrderSystem.{Repo, RefundModel, TransferModel}
  alias Ecto.Multi

  def create_refund(%{order_id: _, amount: _, account_id: _} = params) do
    TransferModel.create_transfer(params)
    |> Multi.merge(fn %{transfer: transfer} ->
      RefundModel.create_refund(%{order_id: params.order_id, transfer_id: transfer.id})
    end)
    |> Repo.transaction()
  end
end
