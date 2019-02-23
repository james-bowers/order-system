defmodule OrderSystem.Product do
  use OrderSystem.BaseSchema
  import Ecto.Changeset

  alias OrderSystem.{Item}

  schema "product" do
    field(:title, :string)
    field(:amount, :integer)
    has_many(:item, Item)
    timestamps()
  end

  def changeset(product, attrs) do
    product
    |> cast(attrs, [:title, :amount])
    |> validate_required([:title, :amount])
  end
end
