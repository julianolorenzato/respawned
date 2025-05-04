defmodule RespawnedWeb.ProfileController do
  use RespawnedWeb, :controller

  alias Respawned.Accounts

  def create(conn, %{"profile" => params}) do
    params
    |> Map.put("account_id", conn.assigns.current_account.id)
    |> Accounts.create_profile()
    |> case do
      {:ok, profile} ->
        conn
        |> put_session(:profile_id, profile.id)
        |> put_flash(:info, "Profile created!")
        |> redirect(to: ~p"/profiles")

      {:error, _} ->
        conn
        |> put_flash(:error, "Oops, something got wrong! :(")
        |> redirect(to: ~p"/profiles/new")
    end
  end
end
