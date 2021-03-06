defmodule Test.OrderSystem.OrderModel do
  use ExUnit.Case
  use Test.OrderSystem.DataCase
  alias Ecto.Multi

  alias OrderSystem.{Order, OrderModel}

  @product1_id "8ea46125-3d93-4858-bd14-c0de1f1a26cb"
  @product2_id "1fe4bc96-dca7-47cf-856c-7535a012df1d"
  @order %{
    items: [
      %{
        product_id: @product1_id,
        quantity: 4
      },
      %{
        product_id: @product2_id,
        quantity: 1
      }
    ]
  }

  test "prepares multi for inserting an order" do
    assert [
             order: {:insert, insert_order_changeset, []},
             merge: {:merge, _func}
           ] = OrderModel.create_order(@order) |> Multi.to_list()
  end

  test "creates multi for reserving items in order" do
    order_id = "5358da8e-4ff4-45b7-b2d5-7ddbcfaaed09"
    order = Map.put(@order, :id, order_id)

    assert [
             {"reserve_item_0",
              {:update_all, prod1_update_query, [set: [order_id: order_id]], []}},
             {"validate_quantity_0", {:run, _reserve_items_func}},
             {"reserve_item_1",
              {:update_all, prod2_update_query, [set: [order_id: order_id]], []}},
             {"validate_quantity_1", {:run, _validate_qty_func}}
           ] = OrderModel.reserve_items(order) |> Multi.to_list()

    assert inspect(prod1_update_query) |> String.contains?("limit: ^4")
    assert inspect(prod2_update_query) |> String.contains?("limit: ^1")

    assert inspect(prod1_update_query)
           |> String.contains?(~s(where: i0.product_id == ^"#{@product1_id}"))

    assert inspect(prod2_update_query)
           |> String.contains?(~s(where: i0.product_id == ^"#{@product2_id}"))

    assert inspect(prod1_update_query) |> String.contains?(~s(select: %{id: i0.id}))
    assert inspect(prod2_update_query) |> String.contains?(~s(select: %{id: i0.id}))
  end

  test "get items in an order" do
    items = OrderModel.retrieve_order(%Order{id: "b03f40b3-5aa8-40f4-92c0-e0bf9d723c3c"})

    assert items == [
             %{
               amount: 3000,
               item_id: "b4c0fb72-e4b0-47fb-958f-20c0a831a2dc",
               title: "A seed data product title"
             },
             %{
               amount: 3000,
               item_id: "9c3be15f-5051-416d-a503-1fddf9bff65c",
               title: "A seed data product title"
             }
           ]
  end
end
