defmodule FrostmountWeb.Lobby do
  use FrostmountWeb, :live_view

  alias Frostmount.Core.Hero
  alias Frostmount.Core.Hero.Validator, as: HeroValidator

  def mount(_params, _session, socket),
    do: {:ok, assign_form(socket)}

  def handle_event("validate", %{"hero" => hero_params}, socket),
    do: {:noreply, validate_form(socket, hero_params)}

  def handle_event("join", _params, %{assigns: %{form: form}} = socket),
    do: {:noreply, redirect(socket, to: ~p"/battlefield?#{form.params}")}

  defp assign_form(socket) do
    form =
      Hero.new()
      |> HeroValidator.changeset(%{})
      |> to_form()

    assign(socket, form: form)
  end

  defp validate_form(socket, hero_params) do
    form =
      Hero.new()
      |> HeroValidator.changeset(hero_params)
      |> Map.put(:action, :validate)
      |> to_form()

    assign(socket, form: form)
  end
end
