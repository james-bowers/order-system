defmodule OrderSystem.Repo.Migrations.Order do
  use Ecto.Migration

  def change do
    create table("order") do
      timestamps()
    end
  end
end
