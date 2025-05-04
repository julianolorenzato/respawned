defmodule RespawnedWeb.Communities.ShowLive do
  use RespawnedWeb, :live_view

  on_mount RespawnedWeb.CurrentCommunityHook

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex border-b border-black shadow-xl">
      <div class="basis-1/2 flex flex-col bg-gray-700 items-center">
        <img class="w-56" src={@current_community.cover_path} />
      </div>

      <div class="basis-1/2 p-12 flex flex-col gap-6">
        <div class="flex items-center justify-between">
          <.badge class="self-start" kind={@current_community.kind} />
          <.link
            navigate={~p"/communities/#{@current_community.id}/info"}
            class="flex items-center gap-1 border-2 border-black rounded-full px-2 hover:bg-black hover:text-white"
          >
            <Lucide.settings class="w-4" />
            <button>
              Management
            </button>
          </.link>
        </div>
        <h1 class="text-6xl font-bold">{@current_community.name}</h1>
        <p class="text-gray-700">{@current_community.description}</p>
      </div>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    crumbs = [
      {"Communities", ~p"/communities"},
      {socket.assigns.current_community.name, nil}
    ]

    socket =
      socket
      |> assign(crumbs: crumbs)

    {:ok, assign(socket, crumbs: crumbs)}
  end
end
