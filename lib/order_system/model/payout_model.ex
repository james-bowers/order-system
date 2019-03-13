defmodule OrderSystem.PayoutModel do
  alias Ecto.Multi
  alias OrderSystem.{Payout}

  def create_payout(%{transfer_id: _, stripe_transfer_id: _} = attrs) do
    Multi.new()
    |> Multi.insert(:payout, insert_payout_changeset(attrs))
  end

  defp insert_payout_changeset(attrs) do
    %Payout{}
    |> Payout.changeset(attrs)
  end
end
