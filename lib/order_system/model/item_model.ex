defmodule OrderSystem.ItemModel do
  # , warn: false
  import Ecto.Query
  # import Ecto.Query
  alias OrderSystem.{Repo, Item}

  def available, do: 1
  def unavailable, do: 0

  def create_items!(params \\ %{}, quantity) do
    item = Item.changeset(%Item{}, params)

    Repo.insert_all(Item, List.duplicate(item.changes, quantity))
  end

  def get_quantity(product_id, :remaining) do
    with {:ok, binary_product_id} <- Ecto.UUID.dump(product_id) do
      query =
        from(i in "item",
          group_by: :available,
          where: i.product_id == ^binary_product_id,
          select: {i.available, count()}
        )

      Repo.all(query)
    end
  end
end
