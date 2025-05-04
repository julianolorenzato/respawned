defmodule RespawnedWeb.CurrentCommunityHook do
  import Phoenix.Component

  alias Respawned.Communities.Community
  alias Respawned.Repo

  def on_mount(:default, %{"id" => community_id}, _session, socket) do
    community = Repo.get(Community, community_id)

    {:cont, assign(socket, current_community: community)}
  end
end
