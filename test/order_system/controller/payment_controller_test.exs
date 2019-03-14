defmodule Test.OrderSystem.PaymentController do
  use Test.OrderSystem.DataCase
  alias OrderSystem.PaymentController
  alias Ecto.Multi

  @order1_id "b03f40b3-5aa8-40f4-92c0-e0bf9d723c3c"
  @account1_id "7f68c8ee-882b-4512-bd73-a7c2147e5f77"
  @account2_id "cde9abbd-bcfd-46d1-a6ed-aec6d2c712ae"

  @valid_pay_order %{
    order_id: @order1_id,
    transfer_to: [
      %{
        account_id: @account1_id,
        amount: 500
      },
      %{
        account_id: @account2_id,
        amount: 300
      }
    ]
  }

  test "records a payment transaction result" do
    assert {:ok,
            %{
              "transaction_0" => transaction_0,
              "transaction_1" => transaction_1
            }} = PaymentController.pay(@valid_pay_order)

    assert transaction_0.transfer.amount == 500
    assert transaction_0.order_id == @order1_id
    assert transaction_0.transfer.id == transaction_0.transfer_id

    assert transaction_1.transfer.amount == 300
    assert transaction_1.order_id == @order1_id
    assert transaction_1.transfer.id == transaction_1.transfer_id
  end

  test "records payment multi result" do
    assert [
             {"transaction_0", {:insert, transac_changeset_0, []}},
             {"transaction_1", {:insert, transac_changeset_1, []}}
           ] = PaymentController.pay_multi(@valid_pay_order) |> Multi.to_list()

    assert transac_changeset_0.valid? == true
    assert transac_changeset_1.valid? == true
  end
end
