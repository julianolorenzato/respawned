defmodule Respawned.Guilds.Member do
  use Respawned.Schema

  @role_options ~w(leader assistant battle_master liutenant fellow)a

  schema "members" do
    field :role, Ecto.Enum, values: @role_options

    timestamps()
  end
end
