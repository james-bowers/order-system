defmodule Test.OrderSystemWeb.Integration.Payment do
  use Test.OrderSystem.DataCase
  use BowersLib.TestSupport.HTTP, OrderSystemWeb.Router

  @order1_id "b03f40b3-5aa8-40f4-92c0-e0bf9d723c3c"
  @account1_id "7f68c8ee-882b-4512-bd73-a7c2147e5f77"
  @account2_id "cde9abbd-bcfd-46d1-a6ed-aec6d2c712ae"

  @valid_body %{
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

  describe "success" do
    test "pays for an order" do
      assert {200, body, _headers} = post("/pay", @valid_body)

      assert %{
               "description" => "Order payment completed.",
               "content" => nil
             } = body
    end
  end

  describe "erroneous" do
    [
      Map.put(@valid_body, :order_id, "invalid-order-id"),
      %{
        order_id: @order1_id,
        transfer_to: [
          %{
            account_id: "invalid",
            amount: 300
          }
        ]
      }
    ]
    |> Enum.with_index()
    |> Enum.each(fn {invalid_body, index} ->
      @invalid_body invalid_body
      test "invalid payment body test #{index}" do
        assert_raise(Ecto.ChangeError, fn ->
          post("/pay", @invalid_body)
        end)
      end
    end)
  end
end
