defmodule Test.OrderSystem.OrderTransferModel do
  use ExUnit.Case
  use Test.OrderSystem.DataCase

  alias OrderSystem.{OrderTransferModel}
  alias Ecto.Multi

  @order1_id "b03f40b3-5aa8-40f4-92c0-e0bf9d723c3c"
  @transfer_id "b1fe7a01-b6af-4c01-981e-0d1e1d420714"

  @valid_attrs %{order_id: @order1_id, transfer_id: @transfer_id}
  test "registers a transfer for a given order (part of the create order db transaction)" do
    assert [
             order_transfer: {:insert, changeset, []}
           ] = OrderTransferModel.create_order_transfer(@valid_attrs) |> Multi.to_list()

    assert changeset.valid? == true

    assert changeset.changes == %{
             order_id: "b03f40b3-5aa8-40f4-92c0-e0bf9d723c3c",
             transfer_id: "b1fe7a01-b6af-4c01-981e-0d1e1d420714"
           }
  end
end
