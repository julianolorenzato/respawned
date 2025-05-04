defmodule RespawnedWeb.Communities.NewLive do
  use RespawnedWeb, :live_view

  alias Respawned.Communities
  alias Respawned.Communities.Community

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex flex-col items-center">
      <.form
        for={@form}
        phx-change="validate"
        phx-submit="save"
        class="max-w-lg flex flex-col gap-3 bg-white shadow border p-4 rounded-lg"
      >
        <h1 class="text-lg font-bold">New Community</h1>
        <.input label="Name" type="text" field={@form[:name]} />
        <.input label="Description" type="textarea" field={@form[:description]} />
        <.input
          label="Kind"
          type="select"
          field={@form[:kind]}
          options={Community.kind_options(:select)}
        />
        <.input label="Cover Path" type="text" field={@form[:cover_path]} />
        <.button>Create</.button>
      </.form>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    crumbs = [
      {"Communities", ~p"/communities"},
      {"New", nil}
    ]

    form =
      %{}
      |> Community.insert_changeset()
      |> to_form()

    {:ok, assign(socket, form: form, crumbs: crumbs)}
  end

  @impl true
  def handle_event("validate", %{"community" => community_params}, socket) do
    form =
      community_params
      |> Community.insert_changeset()
      |> Map.put(:action, :validate)
      |> to_form()

    {:noreply, assign(socket, form: form)}
  end

  @impl true
  def handle_event(
        "save",
        %{"community" => community_params},
        %{assigns: %{current_profile: current_profile}} = socket
      ) do
    first_manager = %{"profile_id" => current_profile.id}

    community_params
    |> Map.put("managers", [first_manager])
    |> Communities.create_community()
    |> case do
      {:ok, _community} ->
        {:noreply,
         socket
         |> put_flash(:success, "Created!")
         |> redirect(to: ~p"/communities")}

      {:error, ch} ->
        IO.inspect(ch)
        {:noreply, put_flash(socket, :error, "Oops! Something got wrong. :(")}
    end
  end
end
