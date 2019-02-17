defmodule OrderSystem.Payout do
  use OrderSystem.BaseSchema
  import Ecto.Changeset

  alias OrderSystem.Transfer

  schema "payout" do
    field(:stripe_transfer_id, :string)
    belongs_to(:transfer, Transfer)

    timestamps()
  end

  def changeset(payout, attrs) do
    payout
    |> cast(attrs, [:transfer_id, :stripe_transfer_id])
    |> validate_required([:transfer_id, :stripe_transfer_id])
  end
end
