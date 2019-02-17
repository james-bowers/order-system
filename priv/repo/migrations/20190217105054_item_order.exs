defmodule OrderSystem.Repo.Migrations.ItemOrder do
  use Ecto.Migration

  def change do
    create table("item_order") do
      add(:item_id, references(:item))
      add(:order_id, references(:order))

      timestamps()
    end
  end
end
