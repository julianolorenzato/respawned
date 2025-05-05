defmodule RespawnedWeb.CurrentProfileHook do
  alias Respawned.Accounts
  use RespawnedWeb, :verified_routes

  import Phoenix.Component
  # import Phoenix.LiveView

  def on_mount(
        :default,
        _params,
        %{"profile_id" => profile_id},
        socket
      ) do
    {:cont, assign(socket, :current_profile, Accounts.get_profile(profile_id))}
  end

  def on_mount(:default, _params, _session, socket) do
    {:cont, assign(socket, :current_profile, nil)}
  end
end
