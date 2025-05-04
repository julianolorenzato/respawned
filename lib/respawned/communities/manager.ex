defmodule Respawned.Communities.Manager do
  use Respawned.Schema

  import Ecto.Changeset

  alias Respawned.Accounts.Profile
  alias Respawned.Communities.Community
  alias Respawned.Communities.Permission

  schema "managers" do
    belongs_to :profile, Profile
    belongs_to :community, Community

    has_many :permissions, Permission

    timestamps()
  end

  @changeset_required ~w(profile_id)a
  @changeset_optional ~w()a

  @doc """
  Used for the first manager of a community.
  """
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, @changeset_required ++ @changeset_optional)
    |> validate_required(@changeset_required)
  end

  @insert_changeset_required ~w(profile_id community_id)a
  @insert_changeset_optional ~w(role)a

  @doc """
  Used for new managers of an existent community.
  """
  def insert_changeset(schema \\ %__MODULE__{}, attrs) do
    schema
    |> cast(attrs, @insert_changeset_required ++ @insert_changeset_optional)
    |> validate_required(@insert_changeset_required)
  end
end
