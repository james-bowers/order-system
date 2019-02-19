defmodule OrderSystem.TransferModel do
  alias OrderSystem.{Repo, Transfer}

  def create_transfer(attrs) do
    %Transfer{}
    |> Transfer.changeset(attrs)
    |> Repo.insert()
  end
end
