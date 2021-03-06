defmodule OrderSystem.Repo.Migrations.Item do
  use Ecto.Migration

  def change do
    create table("item") do
      add(:product_id, references(:product))
      add(:order_id, references(:order))
    end
  end
end
