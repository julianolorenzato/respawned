defmodule Respawned.Accounts do
  alias Respawned.Accounts.Profile
  alias Respawned.Repo
  alias Respawned.Accounts.Account

  def register_account(attrs) do
    Account.insert_changeset(attrs)
    |> Repo.insert()
  end

  @invalid_credentials_message "Invalid email or password"

  def authenticate_account(%{"email" => email, "password" => password}) do
    account =
      email
      |> Account.by_email()
      |> Repo.one()

    case account do
      nil ->
        {:error, @invalid_credentials_message}

      account ->
        if Bcrypt.verify_pass(password, account.password_hash) do
          {:ok, account}
        else
          {:error, @invalid_credentials_message}
        end
    end
  end

  def get_account(account_id) when is_binary(account_id) do
    Account
    |> Repo.get(account_id)
    |> Repo.preload(:profiles)
  end

  def get_first_profile(account_id) when is_binary(account_id) do
    account_id
    |> Profile.by_account_id(preloads: :account, limit: 1)
    |> Repo.one()
  end

  def list_profiles(account_id) when is_binary(account_id) do
    account_id
    |> Profile.by_account_id()
    |> Repo.all()
  end
end
