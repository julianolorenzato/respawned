defmodule Respawned.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :nick, :string, null: true

      add :account_id, references(:accounts, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:profiles, [:nick])
  end
end
