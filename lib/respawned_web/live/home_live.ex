defmodule RespawnedWeb.HomeLive do
  use RespawnedWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex gap-4">
      <%!-- Left section --%>
      <section class="basis-3/12 bg-yellow-500">
        <h1>Next Matches</h1>
      </section>

      <%!-- Middle section --%>
      <section class="basis-6/12 flex flex-col">
        <%!-- Top Guilds --%>
        <div class="bg-zinc-700 text-white flex flex-col">
          <.link class="self-center" href={~p"/communities"}>
            <button class="cursor-pointer hover:bg-zinc-500 bg-zinc-600 p-2">
              Ver todas as comunidades
            </button>
          </.link>
        </div>

        <div class="flex gap-4">
          <%!-- Top Posts --%>
          <div class="basis-1/2">
            <button>New post</button>
            <div>AA</div>
            <div>AA</div>
            <div>AA</div>
            <div>AA</div>
            <div>AA</div>
            <div>AA</div>
          </div>
          <%!-- Top Polls --%>
          <div class="basis-1/2">
            <button>New Poll</button>
            <div>AA</div>
            <div>AA</div>
            <div>AA</div>
            <div>AA</div>
            <div>AA</div>
            <div>AA</div>
          </div>
        </div>
      </section>

      <%!-- Right section --%>
      <section class="basis-3/12 bg-purple-500"></section>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    top_guilds = [
      %{name: "Razz", online_members: 353},
      %{name: "SAD", online_members: 353},
      %{name: "RazSDz", online_members: 353},
      %{name: "Konoha", online_members: 353},
      %{name: "FSDFS", online_members: 353}
    ]

    socket =
      socket
      |> assign(:top_guilds, top_guilds)

    {:ok, socket}
  end

  defp guild_card(assigns) do
    ~H"""
    <%= if @size == "lg" do %>
      <div class="bg-white rounded-lg">
        {@name} aa
      </div>
    <% else %>
      <div class=""></div>
    <% end %>
    """
  end
end
