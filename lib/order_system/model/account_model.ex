defmodule OrderSystem.AccountModel do
  import Ecto.Query, warn: false
  alias OrderSystem.{Repo, Account}

  def get_account!(id), do: Repo.get!(Account, id)

  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end
end
