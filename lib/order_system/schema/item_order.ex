defmodule OrderSystem.ItemOrder do
  use OrderSystem.BaseSchema
  import Ecto.Changeset

  alias OrderSystem.{Item, Order}

  schema "item_order" do
    belongs_to(:item, Item)
    belongs_to(:order, Order)

    timestamps()
  end

  def changeset(item_order, attrs) do
    item_order
    |> cast(attrs, [:item_id, :order_id])
    |> validate_required([:item_id, :order_id])
  end
end
