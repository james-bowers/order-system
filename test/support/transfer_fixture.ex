defmodule Test.TransferFixture do
  alias OrderSystem.{TransferModel}
  @valid_attrs %{account_id: "e898127b-7169-4e31-9b4e-8aba2e6c3451", amount: 5000}

  def create_transfer!(attrs \\ %{}) do
    {:ok, transfer} =
      attrs
      |> Enum.into(@valid_attrs)
      |> TransferModel.create_transfer()

    transfer
  end
end
