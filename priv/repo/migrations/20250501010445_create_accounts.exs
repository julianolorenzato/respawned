defmodule Respawned.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :first_name, :string, null: true
      add :last_name, :string, null: true
      add :email, :string, null: false
      add :password_hash, :string, null: false

      timestamps()
    end

    create unique_index(:accounts, [:email])
  end
end
