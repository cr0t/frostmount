defmodule Frostmount.Core.Beast do
  @moduledoc """
  The Beast models a creature that starts alive with full health, but can be damaged or healed
  along the way. See examples below to get the idea of the flows this poor creature can go through.

  ## Examples

  iex> alias Frostmount.Core.Beast
  iex> %Beast{} = Beast.new()
  iex> 100 = Beast.new() |> Map.get(:health)
  iex> 42 = Beast.new() |> Beast.damage(58) |> Map.get(:health)
  iex> 99 = Beast.new() |> Beast.damage(90) |> Beast.heal(89) |> Map.get(:health)
  iex> true = Beast.new() |> Beast.damage(58) |> Map.get(:is_alive)
  iex> false = Beast.new() |> Beast.damage(99) |> Beast.damage(1) |> Map.get(:is_alive)
  """
  @max_health 100

  defstruct is_alive: true,
            health: @max_health

  def new(),
    do: struct(__MODULE__)

  def heal(%{is_alive: false} = beast, _points),
    do: beast

  def heal(%{health: health} = beast, points) do
    new_health = health + points

    if new_health >= @max_health do
      %{beast | health: @max_health}
    else
      %{beast | health: new_health}
    end
  end

  def damage(%{is_alive: false} = beast, _points),
    do: beast

  def damage(%{health: health} = beast, points) do
    new_health = health - points

    if new_health <= 0 do
      %{beast | is_alive: false, health: 0}
    else
      %{beast | health: new_health}
    end
  end

  def needs_healing?(beast),
    do: beast.is_alive and beast.health < @max_health

  def resurrect(beast),
    do: %{beast | is_alive: true, health: @max_health}
end
