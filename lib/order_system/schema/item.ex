defmodule OrderSystem.Item do
  use OrderSystem.BaseSchema
  import Ecto.Changeset

  alias OrderSystem.{Product, Order}

  schema "item" do
    belongs_to(:product, Product)
    belongs_to(:order, Order)
  end

  def changeset(item, attrs) do
    item
    |> cast(attrs, [:product_id, :order_id])
    |> validate_required([:product_id])
  end
end
