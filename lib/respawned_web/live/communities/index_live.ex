defmodule RespawnedWeb.Communities.IndexLive do
  alias Respawned.Communities
  use RespawnedWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex flex-col gap-4 mt-2 items-center">
      <h1 class="text-3xl font-bold">Communities</h1>

      <ul class="grid grid-cols-4 bg-white p-4 shadow-lg max-w-3xl">
        <.link :for={comm <- @communities} navigate={~p"/communities/#{comm.id}"}>
          <li class="cursor-pointer border border-gray-400 p-2 bg-gradient-to-b from-gray-300 to-gray-200 hover:to-lime-400 flex flex-col gap-2">
            <.badge kind={comm.kind} />
            <h3 class="bg-gray-900 text-white text-center border-2 border-gray-800 shadow-md">
              {comm.name}
            </h3>
            <img src={comm.cover_path} class="w-32 transition-all" />
          </li>
        </.link>
      </ul>

      <.link navigate={~p"/communities/new"}>
        <.button>Create a new community</.button>
      </.link>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    communities = Communities.list_communities()

    crumbs = [{"Communitites", nil}]

    {:ok, assign(socket, communities: communities, crumbs: crumbs)}
  end
end
