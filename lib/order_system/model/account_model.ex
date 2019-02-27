defmodule OrderSystem.AccountModel do
  use OrderSystem.Query

  alias OrderSystem.{Repo, Account}

  def get_account!(%Account{} = account), do: Repo.get!(Account, account.account_id)

  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  def transfer_history(%Account{} = account, options \\ []) do
    query =
      from(a in Account,
        where: a.id == ^account.id,
        inner_join: t in assoc(a, :transfer),
        select: %{amount: t.amount, transfered_at: t.inserted_at},
        order_by: t.inserted_at
      )
      |> paginate(options)

    Repo.all(query)
  end

  def retrieve_products_sold(%Account{} = account, options \\ []) do
    query =
      from(a in Account,
        where: a.id == ^account.id,
        inner_join: t in assoc(a, :transfer),
        inner_join: ot in assoc(t, :order_transfer),
        inner_join: o in assoc(ot, :order),
        inner_join: i in assoc(o, :item),
        inner_join: p in assoc(i, :product),
        select: %{title: p.title, product_id: p.id},
        group_by: p.id
      )
      |> paginate(options)

    Repo.all(query)
  end
end
