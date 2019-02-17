defmodule OrderSystem.Transfer do
  use OrderSystem.BaseSchema
  import Ecto.Changeset

  alias OrderSystem.Account

  schema "transfer" do
    field(:amount, :integer)
    belongs_to(:account, Account)

    timestamps()
  end

  def changeset(transfer, attrs) do
    transfer
    |> cast(attrs, [:account_id, :amount])
    |> validate_required([:account_id, :amount])
  end
end
