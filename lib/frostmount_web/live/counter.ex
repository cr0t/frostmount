defmodule FrostmountWeb.Counter do
  use FrostmountWeb, :live_view

  def render(assigns) do
    ~H"""
    Hello, I'm a LiveView counter.<br /> My value is <%= @counter %><br />
    <button phx-click="inc">+</button>
    <button phx-click="dec">-</button>
    """
  end

  def mount(_params, _session, socket) do
    socket = assign(socket, counter: 0)

    {:ok, socket}
  end

  def handle_event("inc", _params, socket) do
    %{assigns: %{counter: counter}} = socket

    socket = assign(socket, counter: counter + 1)

    {:noreply, socket}
  end

  def handle_event("dec", _params, socket) do
    %{assigns: %{counter: counter}} = socket

    socket = assign(socket, counter: counter - 1)

    {:noreply, socket}
  end
end
