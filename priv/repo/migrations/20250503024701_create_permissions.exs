defmodule Respawned.Repo.Migrations.CreatePermissions do
  use Ecto.Migration

  def change do
    create table(:permissions) do
      add :resource, :string, null: false
      add :type, :string, null: false

      add :manager_id, references(:managers, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:permissions, [:resource, :type, :manager_id])
  end
end
