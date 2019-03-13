defmodule Test.OrderSystem.RefundModel do
  use ExUnit.Case
  use Test.OrderSystem.DataCase

  alias OrderSystem.{RefundModel, Order}
  alias Ecto.Multi

  @valid_attrs %{
    order_id: "b03f40b3-5aa8-40f4-92c0-e0bf9d723c3c",
    transfer_id: "fa24c89f-8708-452f-afd8-3f12678d0282"
  }

  test "refund an order" do
    assert [
             refund: {:insert, changeset, []}
           ] = RefundModel.create_refund(@valid_attrs) |> Multi.to_list()

    assert changeset.valid? == true

    assert changeset.changes == %{
             order_id: "b03f40b3-5aa8-40f4-92c0-e0bf9d723c3c",
             transfer_id: "fa24c89f-8708-452f-afd8-3f12678d0282"
           }
  end

  describe "retrieve refund history" do
    test "For an order with no refunds" do
      refund_history =
        RefundModel.retrieve_refund_history(%Order{id: "b03f40b3-5aa8-40f4-92c0-e0bf9d723c3c"})

      assert refund_history == []
    end

    test "for an order with a refund" do
      refund_history =
        RefundModel.retrieve_refund_history(%Order{id: "1da3cfba-af66-4e22-9eb5-183077617949"})

      assert refund_history == [
               %{
                 refunded_at: ~N[2019-02-23 10:49:22],
                 amount: -2000,
                 order_id: "1da3cfba-af66-4e22-9eb5-183077617949",
                 transfer_id: "9d8ac0d0-53e7-4e7d-b0c1-fb93812c349a"
               }
             ]
    end
  end
end
