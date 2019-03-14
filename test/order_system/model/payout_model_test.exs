defmodule Test.OrderSystem.PayoutModel do
  use ExUnit.Case
  use Test.OrderSystem.DataCase

  alias OrderSystem.{PayoutModel}
  alias Ecto.Multi

  @transfer_id "7e9b4652-b932-4f13-a4f9-5e72ffc1b5ad"

  @valid_attrs %{
    transfer_id: @transfer_id,
    stripe_transfer_id: "trans_12345"
  }

  test "returns Multi to insert a payout" do
    assert [
             payout: {:insert, changeset, []}
           ] = PayoutModel.create_payout(@valid_attrs) |> Multi.to_list()

    assert changeset.valid? == true

    assert changeset.changes == %{
             stripe_transfer_id: "trans_12345",
             transfer_id: "7e9b4652-b932-4f13-a4f9-5e72ffc1b5ad"
           }
  end
end
