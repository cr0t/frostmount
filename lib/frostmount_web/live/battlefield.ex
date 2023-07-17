defmodule FrostmountWeb.Battlefield do
  use FrostmountWeb, :live_view

  def render(assigns) do
    ~H"""
    <p class="mb-2 text-center">
      That's the Battlefield<br /><small><i>(not the FPS game)</i></small>
    </p>
    """
  end

  def mount(_params, _session, socket),
    do: {:ok, socket}
end
