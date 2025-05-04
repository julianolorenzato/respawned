defmodule Respawned.Accounts.Account do
  use Respawned.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias Respawned.Accounts.Profile

  schema "accounts" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :profiles, Profile

    timestamps()
  end

  @insert_changeset_required ~w(email password)a
  @insert_changeset_optional ~w()a

  def insert_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @insert_changeset_required ++ @insert_changeset_optional)
    |> validate_required(@insert_changeset_required)
    |> validate_password()
    |> validate_email()
    |> put_password_hash()
  end

  defp validate_password(changeset) do
    changeset
    |> validate_length(:password, min: 8)
  end

  defp validate_email(changeset) do
    changeset
    |> validate_format(:email, ~r/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/)
    |> unsafe_validate_unique(:email, Respawned.Repo)
    |> unique_constraint(:email)
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: pass}} = changeset) do
    change(changeset, password_hash: Bcrypt.hash_pwd_salt(pass))
  end

  defp put_password_hash(changeset), do: changeset

  def by_email(email) when is_binary(email) do
    from(a in __MODULE__, where: a.email == ^email)
  end
end
