defmodule OrderSystem.TransferModel do
  use OrderSystem.Query
  alias OrderSystem.{Repo, Transfer, Account}

  def create_transfer(attrs) do
    %Transfer{}
    |> Transfer.changeset(attrs)
    |> Repo.insert()
  end

  def get_transfer(%Transfer{} = transfer) do
    case Repo.get(Transfer, transfer.id) do
      nil -> :not_found
      transfer -> {:ok, transfer}
    end
  end

  def get_balance(%Account{} = account) do
    query = from(t in Transfer, where: t.account_id == ^account.id)

    Repo.aggregate(query, :sum, :amount)
  end
end
