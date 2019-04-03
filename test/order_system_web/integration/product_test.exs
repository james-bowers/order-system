defmodule Test.OrderSystemWeb.Integration.Product do
  use Test.OrderSystem.DataCase
  use BowersLib.TestSupport.HTTP, OrderSystemWeb.Router

  @valid_attrs %{amount: 2500, title: "A product title", quantity: 50}
  @invalid_attrs %{quantity: 20}
  @product1_id "8ea46125-3d93-4858-bd14-c0de1f1a26cb"

  test "/product returns 200" do
    assert {200, body, _headers} = post("/product", @valid_attrs)

    assert %{"content" => %{"title" => "A product title", "id" => _product_id}} = body
  end

  test "/product returns 400 when invalid params given" do
    assert {400, body, _headers} = post("/product", @invalid_attrs)

    assert %{
      "description" =>
        "Sorry, we have not created your product, as the request made was invalid.",
      "content" => %{"title" => ["can't be blank"], "amount" => ["can't be blank"]},
      "action" => "product"
    }
  end

  test "/product/:product_id/available returns available quantity" do
    assert {200, body, _headers} = get("/product/#{@product1_id}/available")

    assert %{
             "description" => "Quantity of this product available for purchase.",
             "content" => 3
           } = body
  end

  test "/product/:product_id/available with invalid product_id" do
    assert {400, body, _headers} = get("/product/foo/available")

    assert %{
             "description" => "An invalid ID was provided.",
             "content" => nil
           } = body
  end
end
