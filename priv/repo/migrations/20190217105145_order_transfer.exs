defmodule OrderSystem.Repo.Migrations.OrderTransfer do
  use Ecto.Migration

  def change do
    create table("order_transfer") do
      add(:order_id, references(:order))
      add(:transfer_id, references(:transfer))

      timestamps()
    end
  end
end
