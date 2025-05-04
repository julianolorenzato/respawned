defmodule RespawnedWeb.SessionController do
  alias Respawned.Accounts
  use RespawnedWeb, :controller

  def create(conn, params) do
    case Accounts.authenticate_account(params) do
      {:ok, account} ->
        conn
        |> put_session(:account_id, account.id)
        |> redirect(to: "/")

      {:error, msg} ->
        conn
        |> put_flash(:error, msg)
        |> redirect(to: "/")
    end
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end
end
