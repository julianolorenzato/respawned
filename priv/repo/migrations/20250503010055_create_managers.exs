defmodule Respawned.Repo.Migrations.CreateManagers do
  use Ecto.Migration

  def change do
    create table(:managers) do
      add :profile_id, references(:profiles, on_delete: :delete_all), null: false
      add :community_id, references(:communities, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
