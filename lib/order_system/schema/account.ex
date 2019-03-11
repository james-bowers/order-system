defmodule OrderSystem.Account do
  use OrderSystem.BaseSchema
  import Ecto.Changeset

  alias OrderSystem.Transfer

  schema "account" do
    field(:title, :string)
    field(:stripe_account_id, :string)
    has_many(:transfer, Transfer)

    timestamps()
  end

  def changeset(account, attrs) do
    account
    |> cast(attrs, [:title, :stripe_account_id])
  end
end
