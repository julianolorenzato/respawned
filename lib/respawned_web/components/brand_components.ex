defmodule RespawnedWeb.BrandComponents do
  use Phoenix.Component
  use RespawnedWeb, :verified_routes

  alias Respawned.Communities.Community
  alias Respawned.Accounts.Account
  alias Respawned.Accounts.Profile

  # import RespawnedWeb.CoreComponents

  attr :current_profile, Profile
  attr :current_account, Account

  attr :crumbs, :list

  def breadcrumbs(assigns) do
    ~H"""
    <div class="flex items-center justify-center py-2">
      <div class="flex items-center gap-2 px-4 py-0.5 border border-gray-500 shadow rounded-full bg-white shadow-lg w-full max-w-5xl">
        <Lucide.home class="w-4" />
        <.link href={~p"/"}>
          <span class="px-2 font-bold hover:bg-zinc-600 hover:text-white">Home</span>
        </.link>
        <%= for {name, url} <- @crumbs do %>
          <span>/</span>
          <%= if is_nil(url) do %>
            <span class="px-2 font-bold bg-zinc-800 text-white">{name}</span>
          <% else %>
            <.link navigate={url}>
              <span class="px-2 font-bold hover:bg-zinc-600 hover:text-white">{name}</span>
            </.link>
          <% end %>
        <% end %>
      </div>
    </div>
    """
  end

  attr :kind, :atom, values: Community.kind_options()
  attr :class, :string, default: ""

  def badge(assigns) do
    ~H"""
    <span class={[
      "px-4 text-center bg-gradient-to-r from-yellow-500 to-yellow-400 rounded-full border border-yellow-500 shadow-md text-yellow-900 uppercase",
      @class
    ]}>
      {@kind}
    </span>
    """
  end
end
