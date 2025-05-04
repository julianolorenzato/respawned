defmodule Respawned.Communities.Community do
  use Respawned.Schema

  import Ecto.Changeset

  alias Respawned.Communities.Manager

  @derive {
    Flop.Schema,
    filterable: [:name, :kind], sortable: [:name]
  }

  @kind_options ~w(regular verified official)a

  schema "communities" do
    field :name, :string
    field :description, :string
    field :kind, Ecto.Enum, values: @kind_options
    field :cover_path, :string

    has_many :managers, Manager

    timestamps()
  end

  def kind_options, do: @kind_options

  def kind_options(:select) do
    @kind_options
    |> Enum.map(fn option ->
      {
        option |> Atom.to_string() |> String.capitalize(),
        option
      }
    end)
  end

  @insert_changeset_required ~w(name kind cover_path)a
  @insert_changeset_optional ~w(description)a

  def insert_changeset(schema \\ %__MODULE__{}, attrs) do
    schema
    |> cast(attrs, @insert_changeset_required ++ @insert_changeset_optional)
    |> validate_required(@insert_changeset_required)
    |> cast_assoc(:managers, required: true)
    |> validate_length(:name, min: 1, max: 64)
    |> validate_cover_path_exists()
  end

  defp validate_cover_path_exists(changeset) do
    validate_change(changeset, :cover_path, fn :cover_path, path ->
      clean_path = String.trim_leading(path, "/")
      static_path = Path.join(:code.priv_dir(:respawned), "static/#{clean_path}")

      if File.exists?(static_path) do
        []
      else
        [cover_path: "file not found in static assets"]
      end
    end)
  end
end
