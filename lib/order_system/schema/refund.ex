defmodule OrderSystem.Refund do
  use OrderSystem.BaseSchema
  import Ecto.Changeset

  alias OrderSystem.{Order, Transfer}

  schema "refund" do
    belongs_to(:order, Order)
    belongs_to(:transfer, Transfer)

    timestamps()
  end

  def changeset(refund, attrs) do
    refund
    |> cast(attrs, [:transfer_id, :order_id])
    |> validate_required([:transfer_id, :order_id])
  end
end
