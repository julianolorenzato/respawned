defmodule Respawned.Communities.Permission do
  use Respawned.Schema

  alias Respawned.Communities.Manager

  @resource_options ~w(forum post)a
  @type_options ~w(create delete update)a

  schema "permissions" do
    field :resource, Ecto.Enum, values: @resource_options
    field :type, Ecto.Enum, values: @type_options

    belongs_to :manager, Manager

    timestamps()
  end
end
