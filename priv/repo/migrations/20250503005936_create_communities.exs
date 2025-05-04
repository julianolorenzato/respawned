defmodule Respawned.Repo.Migrations.CreateCommunities do
  use Ecto.Migration

  def change do
    create table(:communities) do
      add :name, :string, null: false
      add :description, :string
      add :kind, :string, null: false
      add :cover_path, :string

      timestamps()
    end
  end
end
