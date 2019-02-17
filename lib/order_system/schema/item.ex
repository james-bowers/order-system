defmodule OrderSystem.Item do
  use OrderSystem.BaseSchema
  import Ecto.Changeset

  alias OrderSystem.Product

  schema "item" do
    field(:available, :integer)
    belongs_to(:product, Product)
  end

  def changeset(item, attrs) do
    item
    |> cast(attrs, [:product_id, :available])
    |> validate_required([:product_id, :available])
  end
end
