defmodule OrderSystem.PayoutModel do
  alias OrderSystem.{Repo, Payout, TransferModel}

  def create_payout(%{amount: _, account_id: _, stripe_transfer_id: _} = attrs) do
    Repo.transaction(fn ->
      with {:ok, transfer_attrs} <- insert_transfer(attrs),
      {:ok, payout} <- insert_payout(transfer_attrs) do
        payout
      else
        {:error, error} -> Repo.rollback(error)
      end
    end)
  end

  defp insert_payout(transfer_attrs) do
    %Payout{}
    |> Payout.changeset(transfer_attrs)
    |> Repo.insert()
  end

  defp insert_transfer(transfer_attrs) do
    with {:ok, transfer} <- TransferModel.create_transfer(transfer_attrs) do
      {:ok, Map.put(transfer_attrs, :transfer_id, transfer.id)}
    else
      {:error, changeset} -> {:error, changeset}
    end
  end
end
