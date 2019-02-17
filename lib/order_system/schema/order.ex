defmodule OrderSystem.Order do
  use OrderSystem.BaseSchema
  import Ecto.Changeset

  schema "order" do
    timestamps()
  end

  def changeset(order, attrs) do
    order
    |> cast(attrs, [])
  end
end
