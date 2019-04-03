defmodule Test.OrderSystemWeb.Integration.Account do
  use Test.OrderSystem.DataCase
  use BowersLib.TestSupport.HTTP, OrderSystemWeb.Router

  @account3_id "eacb49e9-221e-488e-9e6d-a6fb529d5f4b"
  @valid_new_account_id "b6c8aae4-035d-4eb3-b425-32e142cf0d41"
  @valid_attrs %{title: "Account title", id: @valid_new_account_id}

  describe "creates an account" do
    test "/account returns 200 with provided account title" do
      assert {200, body, _headers} = post("/account", @valid_attrs)

      assert %{
               "description" => "A new account has been created.",
               "content" => %{
                 "title" => "Account title",
                 "id" => _account_id
               }
             } = body
    end

    test "/account anonymous account" do
      assert {200, body, _headers} = post("/account", %{id: @valid_new_account_id})

      assert %{
               "description" => "A new account has been created.",
               "content" => %{"title" => nil, "id" => _account_id}
             } = body
    end

    test "/account without id returns 400" do
      assert {400, body, _headers} = post("/account", %{})

      assert %{
               "description" => "An account ID must be provided.",
               "content" => nil
             } = body
    end
  end

  describe "transfer history" do
    test "returns an empty list for non-existant account" do
      unused_id = "9eef8422-d07d-4ecb-9825-00e60bc8b5c4"
      assert {200, body, _headers} = get("/account/#{unused_id}/transfers")

      assert %{
               "description" => "Transfer history for an account.",
               "content" => []
             } = body
    end

    test "returns account balance" do
      assert {200, body, _headers} = get("/account/#{@account3_id}/balance")

      assert %{
               "description" => "The account's current balance.",
               "content" => 2000
             } = body
    end

    test "account balance for an invalid account id" do
      assert {400, _body, _headers} = get("/account/foo/balance")
    end

    test "account balance for non existent account" do
      assert {404, body, _headers} = get("/account/e308f1f4-f66d-4c60-a7c3-669596797cba/balance")

      assert %{
               "description" => "The account could not be found.",
               "content" => nil
             } = body
    end

    test "returns account's transfer history" do
      assert {200, body, _headers} = get("/account/#{@account3_id}/transfers")

      assert %{
               "description" => "Transfer history for an account.",
               "content" => [
                 %{"transfered_at" => "2019-02-22T16:59:38", "amount" => 1000},
                 %{"transfered_at" => "2019-02-22T16:59:39", "amount" => 3000},
                 %{"transfered_at" => "2019-02-22T16:59:40", "amount" => -2000}
               ]
             } = body
    end

    test "errors for an invalid account id" do
      assert {400, body, _headers} = get("/account/foo/transfers")

      assert %{
               "description" => "An invalid ID was provided.",
               "content" => nil
             } = body
    end
  end
end
