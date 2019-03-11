defmodule OrderSystem.ItemModel do
  use OrderSystem.Query
  alias OrderSystem.{Repo, Item}

  def get_quantity(%Item{} = item, :available) do
    query =
      from(i in Item,
        where: is_nil(i.order_id) and i.product_id == ^item.product_id,
        select: count()
      )

    Repo.one(query)
  end
end
