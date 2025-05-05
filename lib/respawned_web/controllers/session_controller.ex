defmodule RespawnedWeb.SessionController do
  use RespawnedWeb, :controller

  alias Respawned.Accounts

  def create(conn, params) do
    case Accounts.authenticate_account(params) do
      {:ok, account} ->
        first_profile = Accounts.get_first_profile(account.id)

        conn
        |> put_session(:account_id, account.id)
        # every time user sign in, the first profile is selected (if the profile exists)
        |> then(fn conn ->
          if is_nil(first_profile),
            do: put_session(conn, :profile_id, nil),
            else: put_session(conn, :profile_id, first_profile.id)
        end)
        |> redirect(to: "/")

      {:error, msg} ->
        conn
        |> put_flash(:error, msg)
        |> redirect(to: "/")
    end
  end

  def update(conn, %{"profile_id" => profile_id}) when is_binary(profile_id) do
    conn
    |> put_session(:profile_id, profile_id)
    |> redirect(to: ~p"/profiles")
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end
end
