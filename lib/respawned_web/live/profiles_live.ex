defmodule RespawnedWeb.ProfilesLive do
  use RespawnedWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <div class="h-full flex flex-col pt-4 items-center gap-4">
      <.link class="w-full max-w-lg" href={~p"/"}>
        <.button class="flex items-center gap-2">
          <Lucide.chevron_left class="w-4" />
          <span>
            Go back
          </span>
        </.button>
      </.link>

      <div class="border border-black p-4 w-full max-w-lg">
        <h1 class="font-bold text-3xl mb-4 text-center">Profiles</h1>

        <div
          :for={profile <- @current_account.profiles}
          class="flex items-center justify-between p-4 bg-gray-700 text-white"
        >
          <span class="text-lg">
            {profile.nick}
          </span>
          <span :if={profile.id == @current_profile.id}>
            Active
          </span>
        </div>
      </div>

      <div></div>
    </div>
    """
  end
end
