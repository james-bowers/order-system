defmodule OrderSystem.TransferModel do
  import Ecto.Query, warn: false
  alias OrderSystem.{Repo, Transfer}

  def create_transfer(attrs) do
    %Transfer{}
    |> Transfer.changeset(attrs)
    |> Repo.insert()
  end

  def get_transfer!(id) do
    Repo.get!(Transfer, id)
  end

  def get_balance!(account_id) do
    query = from(t in Transfer, where: t.account_id == ^account_id)

    Repo.aggregate(query, :sum, :amount)
  end
end
