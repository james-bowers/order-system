# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     OrderSystem.Repo.insert!(%OrderSystem.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

IO.puts("Setting up seed data...")

account1_id = "7f68c8ee-882b-4512-bd73-a7c2147e5f77"
account2_id = "cde9abbd-bcfd-46d1-a6ed-aec6d2c712ae"
account3_id = "eacb49e9-221e-488e-9e6d-a6fb529d5f4b"

product1_id = "8ea46125-3d93-4858-bd14-c0de1f1a26cb"

transfer1_id = "93640c62-0485-4a32-aa19-2f71d905bea7"
transfer2_id = "d52003be-9363-41f2-a293-8889f13cb82d"
transfer3_id = "672a6dbd-9490-4c2a-af60-4be441b66979"
transfer4_id = "22a8daee-5944-4cec-9a1f-9334a8c11640"
transfer5_id = "9d8ac0d0-53e7-4e7d-b0c1-fb93812c349a"

order1_id = "b03f40b3-5aa8-40f4-92c0-e0bf9d723c3c"
order2_id = "1da3cfba-af66-4e22-9eb5-183077617949"

refund1_id = "e83bef5c-9294-40fb-a401-ed191e3c7662"
######################################################
# Account

OrderSystem.Repo.insert!(%OrderSystem.Account{
  id: account1_id,
  inserted_at: ~N[2019-02-22 06:58:01],
  stripe_account_id: nil,
  title: "seed account title",
  updated_at: ~N[2019-02-22 06:58:01]
})

OrderSystem.Repo.insert!(%OrderSystem.Account{
  id: account2_id,
  inserted_at: ~N[2019-02-22 06:58:01],
  stripe_account_id: nil,
  title: "seed account title",
  updated_at: ~N[2019-02-22 06:58:01]
})

OrderSystem.Repo.insert!(%OrderSystem.Account{
  id: account3_id,
  inserted_at: ~N[2019-02-22 06:58:01],
  stripe_account_id: nil,
  title: "seed account title",
  updated_at: ~N[2019-02-22 06:58:01]
})

######################################################
# Product

OrderSystem.Repo.insert!(%OrderSystem.Product{
  amount: 3000,
  id: product1_id,
  inserted_at: ~N[2019-02-22 07:01:34],
  title: "A seed data product title",
  updated_at: ~N[2019-02-22 07:01:34]
})

######################################################
# Product items

# Available items
OrderSystem.Repo.insert!(%OrderSystem.Item{
  id: "b1a62eae-ec0c-4b81-8cbc-9986b234d898",
  order_id: nil,
  product_id: product1_id
})

OrderSystem.Repo.insert!(%OrderSystem.Item{
  id: "fcac0119-0fe0-473e-b3d2-5b9f5defda3b",
  order_id: nil,
  product_id: product1_id
})

OrderSystem.Repo.insert!(%OrderSystem.Item{
  id: "fa2a9050-c988-4987-9fc4-eeeb94a42690",
  order_id: nil,
  product_id: product1_id
})

######################################################
# Transfer

OrderSystem.Repo.insert!(%OrderSystem.Transfer{
  account_id: account1_id,
  amount: 1500,
  id: transfer1_id,
  inserted_at: ~N[2019-02-22 16:59:38],
  updated_at: ~N[2019-02-22 16:59:38]
})

OrderSystem.Repo.insert!(%OrderSystem.Transfer{
  account_id: account2_id,
  amount: 500,
  id: transfer2_id,
  inserted_at: ~N[2019-02-22 16:59:38],
  updated_at: ~N[2019-02-22 16:59:38]
})

OrderSystem.Repo.insert!(%OrderSystem.Transfer{
  account_id: account3_id,
  amount: 1000,
  id: transfer3_id,
  inserted_at: ~N[2019-02-22 16:59:38],
  updated_at: ~N[2019-02-22 16:59:38]
})

OrderSystem.Repo.insert!(%OrderSystem.Transfer{
  account_id: account3_id,
  amount: 3000,
  id: transfer4_id,
  inserted_at: ~N[2019-02-22 16:59:38],
  updated_at: ~N[2019-02-22 16:59:38]
})

OrderSystem.Repo.insert!(%OrderSystem.Transfer{
  account_id: account3_id,
  amount: -2000,
  id: transfer5_id,
  inserted_at: ~N[2019-02-22 16:59:38],
  updated_at: ~N[2019-02-22 16:59:38]
})

######################################################
# Order
OrderSystem.Repo.insert!(%OrderSystem.Order{
  id: order1_id,
  inserted_at: ~N[2019-02-22 16:47:07],
  updated_at: ~N[2019-02-22 16:47:07]
})

OrderSystem.Repo.insert!(%OrderSystem.Order{
  id: order2_id,
  inserted_at: ~N[2019-02-22 16:47:07],
  updated_at: ~N[2019-02-22 16:47:07]
})

######################################################
# Items associated to an order
OrderSystem.Repo.insert!(%OrderSystem.Item{
  id: "b4c0fb72-e4b0-47fb-958f-20c0a831a2dc",
  order_id: order1_id,
  product_id: product1_id
})

OrderSystem.Repo.insert!(%OrderSystem.Item{
  id: "9c3be15f-5051-416d-a503-1fddf9bff65c",
  order_id: order1_id,
  product_id: product1_id
})

OrderSystem.Repo.insert!(%OrderSystem.Item{
  id: "cb042b93-c126-41ef-ae0e-3071c1cfd122",
  order_id: order2_id,
  product_id: product1_id
})

######################################################
# Order to transfer link
OrderSystem.Repo.insert!(%OrderSystem.OrderTransfer{
  id: "bc7d8b89-d40a-424e-bc5b-d9572bfc37a8",
  inserted_at: ~N[2019-02-22 17:06:19],
  order_id: order1_id,
  transfer_id: transfer1_id,
  updated_at: ~N[2019-02-22 17:06:19]
})

OrderSystem.Repo.insert!(%OrderSystem.OrderTransfer{
  id: "55082c47-e13b-4e98-9ad7-2e89492410c0",
  inserted_at: ~N[2019-02-22 17:06:19],
  order_id: order1_id,
  transfer_id: transfer1_id,
  updated_at: ~N[2019-02-22 17:06:19]
})

OrderSystem.Repo.insert!(%OrderSystem.OrderTransfer{
  id: "25679df9-329e-4aaf-9b3a-921a9928e48f",
  inserted_at: ~N[2019-02-22 17:06:19],
  order_id: order1_id,
  transfer_id: transfer1_id,
  updated_at: ~N[2019-02-22 17:06:19]
})

OrderSystem.Repo.insert!(%OrderSystem.OrderTransfer{
  id: "d68aa2f5-8638-4e9b-b214-f21b57ce2654",
  inserted_at: ~N[2019-02-22 17:06:19],
  order_id: order2_id,
  transfer_id: transfer4_id,
  updated_at: ~N[2019-02-22 17:06:19]
})

######################################################
# Refund
OrderSystem.Repo.insert!(%OrderSystem.Refund{
  id: refund1_id,
  inserted_at: ~N[2019-02-23 10:49:22],
  order_id: order2_id,
  transfer_id: transfer5_id,
  updated_at: ~N[2019-02-23 10:49:22]
})

IO.puts("Done.")
