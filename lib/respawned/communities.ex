defmodule Respawned.Communities do
  alias Respawned.Repo
  alias Respawned.Communities.Community

  def create_community(attrs) do
    attrs
    |> Community.insert_changeset()
    |> Repo.insert()
  end

  def list_communities() do
    Community
    |> Repo.all()
  end
end
