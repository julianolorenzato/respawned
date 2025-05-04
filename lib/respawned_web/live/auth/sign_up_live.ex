defmodule RespawnedWeb.Auth.SignUpLive do
  use RespawnedWeb, :live_view

  alias Respawned.Accounts
  alias Respawned.Accounts.Account

  @impl true
  def mount(_params, _session, socket) do
    form =
      %{}
      |> Account.insert_changeset()
      |> to_form()

    {:ok, assign(socket, form: form)}
  end

  @impl true
  def handle_event("validate", %{"account" => params}, socket) do
    form =
      params
      |> Account.insert_changeset()
      |> Map.put(:action, :validate)
      |> to_form()

    {:noreply, assign(socket, form: form)}
  end

  @impl true
  def handle_event("save", %{"account" => params}, socket) do
    params
    |> Accounts.register_account()
    |> case do
      {:ok, _account} ->
        {:noreply, put_flash(socket, :info, "Registrado com sucesso")}

      {:error, %Ecto.Changeset{}} ->
        {:noreply, put_flash(socket, :error, "ops")}
    end
  end
end
