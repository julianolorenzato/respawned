defmodule RespawnedWeb.Communities.Management.LayoutLive do
  use RespawnedWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex">
      <nav class="basis-lg">
        <.link to={}>

        </.link>

      </nav>
      <div></div>
    </div>
    """
  end
end
