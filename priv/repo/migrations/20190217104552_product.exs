defmodule OrderSystem.Repo.Migrations.Product do
  use Ecto.Migration

  def change do
    create table("product") do
      add(:amount, :integer)
      add(:title, :string)

      timestamps()
    end
  end
end
