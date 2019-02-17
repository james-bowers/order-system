defmodule OrderSystem.Repo.Migrations.Account do
  use Ecto.Migration

  def change do
    create table("account") do
      add(:title, :string)
      add(:stripe_account_id, :string)

      timestamps()
    end
  end
end
