defmodule FrostmountWeb.Lobby do
  use FrostmountWeb, :live_view

  def render(assigns) do
    ~H"""
    <p class="mb-2 text-center">
      You're about to join the group of <i>adventurous wanderers</i>. Reveal yourself, stranger!
    </p>
    """
  end

  def mount(_params, _session, socket),
    do: {:ok, socket}
end
