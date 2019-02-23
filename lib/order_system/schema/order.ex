defmodule OrderSystem.Order do
  use OrderSystem.BaseSchema
  import Ecto.Changeset

  alias OrderSystem.{OrderTransfer, Item}

  schema "order" do
    has_many(:order_transfer, OrderTransfer)
    has_many(:item, Item)
    timestamps()
  end

  def changeset(order, attrs) do
    order
    |> cast(attrs, [])
  end
end
