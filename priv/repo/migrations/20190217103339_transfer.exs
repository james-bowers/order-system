defmodule OrderSystem.Repo.Migrations.Transfer do
  use Ecto.Migration

  def change do
    create table("transfer") do
      add(:account_id, references(:account))
      add(:amount, :integer)

      timestamps()
    end
  end
end
