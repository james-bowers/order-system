defmodule OrderSystem.OrderTransfer do
  use OrderSystem.BaseSchema
  import Ecto.Changeset

  alias OrderSystem.{Transfer, Order}

  schema "order_transfer" do
    belongs_to(:order, Order)
    belongs_to(:transfer, Transfer)

    timestamps()
  end

  def changeset(order_transfer, attrs) do
    order_transfer
    |> cast(attrs, [:transfer_id, :order_id])
    |> validate_required([:transfer_id, :order_id])
  end
end
