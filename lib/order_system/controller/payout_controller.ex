defmodule OrderSystem.PayoutController do
  alias OrderSystem.{Repo, PayoutModel, TransferModel}
  alias Ecto.Multi

  def create_payout(%{stripe_transfer_id: _, amount: _, account_id: _} = params) do
    TransferModel.create_transfer(params)
    |> Multi.merge(fn %{transfer: transfer} ->
      PayoutModel.create_payout(%{
        stripe_transfer_id: params.stripe_transfer_id,
        transfer_id: transfer.id
      })
    end)
    |> Repo.transaction()
  end
end
