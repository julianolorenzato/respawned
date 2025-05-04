defmodule RespawnedWeb.OnboardingLive do
  alias Respawned.Accounts.Profile
  use RespawnedWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <div class="h-full flex flex-col gap-8 items-center justify-center">
      <%!-- <div class="flex flex-col gap-4 items-center"> --%>
      <h1 class="font-bold text-3xl">Bem vindo ao RESPAWNED</h1>
      <h1 class="font-light">Como devemos te chamar?</h1>
      <%!-- </div> --%>

      <.form
        action={~p"/profiles"}
        method="post"
        phx-change="validate"
        class="flex flex-col gap-4"
        for={@form}
      >
        <.input placeholder="Seu nickname" field={@form[:nick]} />
        <.button type="submit">Finalizar</.button>
      </.form>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, %{assigns: %{current_profile: %Profile{}}} = socket) do
    {:ok,
     socket
     |> put_flash(:error, "You are already onboarded.")
     |> redirect(to: ~p"/")}
  end

  @impl true
  def mount(_params, _session, socket) do
    form =
      %{}
      |> Profile.insert_changeset()
      |> to_form()

    {:ok, assign(socket, form: form)}
  end

  @impl true
  def handle_event("validate", %{"profile" => profile_params}, socket) do
    form =
      profile_params
      |> Profile.insert_changeset()
      |> Map.put(:action, :validate)
      |> to_form()

    {:noreply, assign(socket, form: form)}
  end
end
