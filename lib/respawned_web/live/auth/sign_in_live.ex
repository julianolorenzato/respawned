defmodule RespawnedWeb.Auth.SignInLive do
  use RespawnedWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}))}
  end
end
