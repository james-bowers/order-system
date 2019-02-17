defmodule OrderSystem.Repo.Migrations.Payout do
  use Ecto.Migration

  def change do
    create table("payout") do
      add(:transfer_id, references(:transfer))
      add(:stripe_transfer_id, :string)

      timestamps()
    end
  end
end
