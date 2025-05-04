defmodule RespawnedWeb.CurrentProfileHook do
  alias Respawned.Accounts
  use RespawnedWeb, :verified_routes

  import Phoenix.Component
  # import Phoenix.LiveView

  def on_mount(
        :default,
        _params,
        %{"account_id" => account_id},
        socket
      ) do
    {:cont, assign(socket, :current_profile, Accounts.get_first_profile(account_id))}
  end

  def on_mount(:default, _params, _session, socket) do
    {:cont, assign(socket, :current_profile, nil)}
  end
end
