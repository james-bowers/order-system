defmodule Test.OrderSystem.PayoutModel do
  use ExUnit.Case
  use Test.OrderSystem.DataCase

  alias OrderSystem.{PayoutModel, Transfer, TransferModel}

  test "logs a payout in the transfer table" do
    account1_id = "7f68c8ee-882b-4512-bd73-a7c2147e5f77"

    valid_attrs = %{
      amount: -5000,
      account_id: account1_id,
      stripe_transfer_id: "trans_12345"
    }

    {:ok, payout} = PayoutModel.create_payout(valid_attrs)

    assert {:ok, %Transfer{amount: -5000}} =
             TransferModel.get_transfer(%Transfer{id: payout.transfer_id})
  end

  test "rollback failure when inserting payout" do
    account1_id = "7f68c8ee-882b-4512-bd73-a7c2147e5f77"

    invalid_attrs = %{account_id: account1_id, amount: -5000}

    {:error, changeset} = PayoutModel.create_payout(invalid_attrs)
    assert errors_on(changeset) == %{stripe_transfer_id: ["can't be blank"]}
  end
end
