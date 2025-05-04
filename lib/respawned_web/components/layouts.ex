defmodule RespawnedWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use RespawnedWeb, :controller` and
  `use RespawnedWeb, :live_view`.
  """
  use RespawnedWeb, :html

  embed_templates "layouts/*"

  def page_header(assigns) do
    ~H"""
    <header class="bg-white flex h-16 px-8 items-center justify-between border-b border-black">
      <h1 class="font-bold text-2xl">RESPAWNED</h1>

      <%= if @current_account do %>
        <div class="flex items-center gap-4">
          <.link :if={@current_profile} href={~p"/profiles"}>
            <button class="bg-gray-900 hover:bg-gray-700 cursor-pointer text-white rounded-full p-2">
              <Lucide.arrow_down_up class="w-4 h-4" />
            </button>
          </.link>

          <div class="flex flex-col">
            <span class="text-sm">
              {@current_account.email}
            </span>

            <span :if={@current_profile}>
              {@current_profile.nick}
            </span>
          </div>
        </div>

        <.link href={~p"/auth/sign-out"} method="delete">
          <.button>Sign Out</.button>
        </.link>
      <% else %>
        <div>
          <.link href={~p"/auth/sign-up"}>
            <.button>Sign Up</.button>
          </.link>

          <.link href={~p"/auth/sign-in"}>
            <.button>Sign In</.button>
          </.link>
        </div>
      <% end %>
    </header>
    """
  end
end
