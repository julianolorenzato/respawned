defmodule RespawnedWeb.Auth do
  use RespawnedWeb, :verified_routes

  import Phoenix.Controller
  import Plug.Conn

  alias Respawned.Accounts
  alias Respawned.Accounts.Account
  alias Respawned.Accounts.Profile
  alias Respawned.Repo

  def ensure_authenticated(conn, _opts) do
    case get_session(conn, :account_id, nil) do
      account_id when is_binary(account_id) ->
        case Repo.get(Account, account_id) do
          %Account{} ->
            conn

          nil ->
            conn
            |> put_flash(:error, "Usuário não encontrado")
            |> redirect(to: ~p"/")
            |> clear_session()
            |> halt()
        end

      nil ->
        conn
        |> put_flash(:info, "Você precisa estar autenticado para acessar este recurso.")
        |> redirect(to: ~p"/")
        |> halt()
    end
  end

  def fetch_current_account(conn, _opts) do
    account_id = get_session(conn, :account_id, nil)

    case account_id do
      nil ->
        assign(conn, :current_account, nil)

      _ ->
        assign(conn, :current_account, Accounts.get_account(account_id))
    end
  end

  def fetch_current_profile(conn, _opts) do
    account_id = get_session(conn, :account_id, nil)

    case account_id do
      nil ->
        assign(conn, :current_profile, nil)

      _ ->
        assign(conn, :current_profile, Accounts.get_first_profile(account_id))
    end
  end

  def check_onboarding(
        %Plug.Conn{
          assigns: %{
            current_account: current_account,
            current_profile: current_profile
          },
          request_path: request_path
        } = conn,
        _ops
      ) do
    case {current_account, current_profile} do
      {nil, nil} ->
        conn

      {%Account{}, %Profile{}} ->
        conn

      {%Account{}, nil} ->
        if String.starts_with?(request_path, "/onboarding") do
          conn
        else
          redirect(conn, to: ~p"/onboarding")
        end
    end
  end
end
