defmodule Respawned.Accounts.Profile do
  use Respawned.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias Respawned.Accounts.Account

  schema "profiles" do
    field :nick, :string

    belongs_to :account, Account

    timestamps()
  end

  @insert_changeset_required ~w(nick account_id)a
  @insert_changeset_optional ~w()a

  @doc """
  Used for insert new Profiles for an existing Account.
  """
  def insert_changeset(schema \\ %__MODULE__{}, attrs) do
    schema
    |> cast(attrs, @insert_changeset_required ++ @insert_changeset_optional)
    |> validate_required(@insert_changeset_required)
    |> validate_nick()
  end

  defp validate_nick(changeset) do
    changeset
    |> validate_length(:nick, min: 3, max: 20)
    |> unique_constraint(:nick)
    |> unsafe_validate_unique(:nick, Respawned.Repo)
  end

  def by_account_id(account_id, opts \\ []) do
    from(p in __MODULE__,
      where: p.account_id == ^account_id,
      preload: ^Keyword.get(opts, :preloads, []),
      limit: ^Keyword.get(opts, :limit, nil)
    )
  end
end
