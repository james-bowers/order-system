defmodule OrderSystem.Repo.Migrations.Refund do
  use Ecto.Migration

  def change do
    create table("refund") do
      add(:order_id, references(:order))
      add(:transfer_id, references(:transfer))

      timestamps()
    end
  end
end
