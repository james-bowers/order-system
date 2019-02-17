defmodule OrderSystem.Account do
  use OrderSystem.BaseSchema
  import Ecto.Changeset

  schema "account" do
    field(:title, :string)
    field(:stripe_account_id, :string)

    timestamps()
  end

  def changeset(account, attrs) do
    account
    |> cast(attrs, [:title, :stripe_account_id])
    |> validate_required([:title])
  end
end
