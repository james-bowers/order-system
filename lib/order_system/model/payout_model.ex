defmodule OrderSystem.PayoutModel do
  alias OrderSystem.{Repo, Payout, TransferModel}

  def create_payout(%{amount: _, account_id: _, stripe_transfer_id: _} = attrs) do
    Repo.transaction(fn ->
      transfer_attrs = insert_transfer!(attrs)

      %Payout{}
      |> Payout.changeset(transfer_attrs)
      |> Repo.insert!()
    end)
  end

  defp insert_transfer!(transfer_attrs) do
    {:ok, transfer} = TransferModel.create_transfer(transfer_attrs)

    transfer_attrs
    |> Map.put(:transfer_id, transfer.id)
  end
end
