# OrderSystem

Manages inventory, and financial accounts.

## Tests:

With docker & postgres: `docker-compose run test`
Without docker (relies on local postgres running): `mix test`

## Routes (work in progress)

`POST /account`
`GET /balance/:account_id`
`GET /product/:product_id`

```
POST /payout
{
  amount: 3000,
  account_id: 'abcde'
}
```

```
POST /pay
{
  stripe_token: 'abc',
  order_id: 'xyz',
  to_accounts: {
    <account_id>: <amount>
  }
}
```

```
POST /order
{
  products: {
    <product_id>: <product_quantity>
  }
}
```

`POST /product`
