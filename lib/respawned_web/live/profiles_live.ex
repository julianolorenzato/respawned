defmodule RespawnedWeb.ProfilesLive do
  use RespawnedWeb, :live_view
  
  alias Respawned.Accounts.Profile

  @impl true
  def render(assigns) do
    ~H"""
    <div class="h-full flex flex-col pt-4 items-center gap-4">
      <div class="w-full max-w-lg flex items-center justify-between">
        <.link href={~p"/"}>
          <.button class="flex items-center gap-2">
            <Lucide.chevron_left class="w-4" />
            <span>
              Go back
            </span>
          </.button>
        </.link>

        <%= case @live_action do %>
          <% :new  -> %>
            <.link patch={~p"/profiles"}>
              <.button class="flex items-center gap-2">
                <span>
                  Profiles
                </span>
                <Lucide.user_round class="w-4" />
              </.button>
            </.link>
          <% :index  -> %>
            <.link patch={~p"/profiles/new"}>
              <.button class="flex items-center gap-2">
                <span>
                  New Profile
                </span>
                <Lucide.plus class="w-4" />
              </.button>
            </.link>
        <% end %>
      </div>

      <%= case @live_action do %>
        <% :new -> %>
          <.form
            :if={@live_action == :new}
            phx-change="validate"
            action={~p"/profiles"}
            method="post"
            for={@form}
            class="w-full max-w-lg flex flex-col gap-2 p-4 border border-black"
          >
            <.input label="Nickname" field={@form[:nick]} />
            <.button phx-disable-with="Saving..." disabled={!@form.source.valid?} class="w-full">
              Create profile
            </.button>
          </.form>
        <% :index -> %>
          <div class="border border-black p-4 w-full max-w-lg">
            <h1 class="font-bold text-3xl mb-4 text-center">Profiles</h1>

            <div class="flex flex-col gap-1">
              <div
                :for={profile <- @current_account.profiles}
                class="cursor-pointer hover:bg-gray-600 flex items-center justify-between p-4 bg-gray-700 text-white"
              >
                <span class="text-lg">
                  {profile.nick}
                </span>
                <span :if={profile.id == @current_profile.id}>
                  Active
                </span>
              </div>
            </div>
          </div>
      <% end %>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, %{assigns: %{current_account: account}} = socket) do
    form =
      %{"account_id" => account.id}
      |> Profile.insert_changeset()
      |> to_form()

    {:ok, assign(socket, form: form)}
  end

  @impl true
  def handle_event(
        "validate",
        %{"profile" => params},
        %{assigns: %{current_account: account}} = socket
      ) do
    form =
      params
      |> Map.put("account_id", account.id)
      |> Profile.insert_changeset()
      |> Map.put(:action, :validate)
      |> to_form()

    {:noreply, assign(socket, form: form)}
  end

  @impl true
  def handle_params(_unsigned_params, _uri, socket) do
    {:noreply, socket}
  end
end
