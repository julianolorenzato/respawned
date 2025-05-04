defmodule RespawnedWeb.CurrentAccountHook do
  use RespawnedWeb, :verified_routes

  import Phoenix.Component

  alias Respawned.Accounts

  def on_mount(
        :default,
        _params,
        %{"account_id" => account_id},
        socket
      ) do
    {:cont, assign(socket, :current_account, Accounts.get_account(account_id))}
  end

  def on_mount(:default, _params, _session, socket) do
    {:cont, assign(socket, :current_account, nil)}
  end
end
