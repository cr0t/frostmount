defmodule FrostmountWeb.Battlefield do
  use FrostmountWeb, :live_view

  import Frostmount.Dispatcher

  alias Frostmount.Core.{Beast, Hero}

  @heal_period 500
  @heal_points 5

  def mount(%{"name" => name, "strength" => strength}, _session, socket),
    do: start_game(name, strength, socket)

  def mount(%{"name" => name}, _session, socket),
    do: start_game(name, randomize_strength(), socket)

  def mount(_params, _session, socket),
    do: {:ok, redirect(socket, to: ~p"/")}

  defp start_game(name, strength, socket) do
    uuid = generate_uuid()
    hero = Hero.new(name: name, avatar: Enum.random(1..9), strength: String.to_integer(strength))
    beast = Beast.new()

    if connected?(socket) do
      subscribe(uuid, hero)
      broadcast(:retrieve_beast_master_state)
    end

    socket =
      socket
      |> assign(%{
        uuid: uuid,
        hero: hero,
        beast: beast,
        members: %{}
      })
      |> handle_joins(presence_list())

    schedule_beast_healing()

    {:ok, socket}
  end

  ###
  ### Game Logic
  ###

  def handle_event("attack", _value, socket) do
    %{uuid: uuid, hero: hero} = socket.assigns
    damage = :rand.uniform(hero.strength)

    broadcast({:attack, uuid, damage})

    {:noreply, socket}
  end

  def handle_event("respawn", _value, socket) do
    beast = Beast.new()

    broadcast({:update_the_beast, beast})

    {:noreply, assign(socket, :beast, beast)}
  end

  def handle_info({:attack, attacker_uuid, damage}, socket) do
    %{beast: beast} = socket.assigns

    if i_am_master?(socket),
      do: broadcast({:update_the_beast, Beast.damage(beast, damage)})

    socket = push_event(socket, "animate", %{id: "member-#{attacker_uuid}"})

    {:noreply, socket}
  end

  def handle_info(:heal_the_beast, socket) do
    %{beast: beast, members: members} = socket.assigns

    if i_am_master?(socket) and Beast.needs_healing?(beast) do
      adjusted_heal_points = @heal_points + extra_heal_points(members)

      broadcast({:update_the_beast, Beast.heal(beast, adjusted_heal_points)})
    end

    schedule_beast_healing()

    {:noreply, socket}
  end

  def handle_info(:retrieve_beast_master_state, socket) do
    if i_am_master?(socket),
      do: broadcast({:update_the_beast, socket.assigns.beast})

    {:noreply, socket}
  end

  def handle_info({:update_the_beast, beast}, socket),
    do: {:noreply, assign(socket, :beast, beast)}

  ###
  ### Presence Handler & Helpers
  ###

  def handle_info(%{event: "presence_diff", payload: diff}, socket) do
    socket =
      socket
      |> handle_leaves(diff.leaves)
      |> handle_joins(diff.joins)

    {:noreply, socket}
  end

  defp handle_joins(socket, joins) do
    Enum.reduce(joins, socket, fn {member, %{metas: [meta | _]}}, socket ->
      assign(socket, :members, Map.put(socket.assigns.members, member, meta))
    end)
  end

  defp handle_leaves(socket, leaves) do
    Enum.reduce(leaves, socket, fn {member, _}, socket ->
      assign(socket, :members, Map.delete(socket.assigns.members, member))
    end)
  end

  ###
  ### Helpers
  ###

  defp randomize_strength(),
    do: Enum.random(2..@heal_points) |> to_string()

  defp generate_uuid(),
    do: :uuid.get_v4() |> :uuid.uuid_to_string() |> to_string()

  defp schedule_beast_healing(),
    do: Process.send_after(self(), :heal_the_beast, @heal_period)

  defp sort_members(members) do
    members
    |> Map.values()
    |> Enum.sort(&(DateTime.compare(&1[:joined_at], &2[:joined_at]) != :gt))
  end

  defp master_uuid(members),
    do: members |> sort_members() |> hd() |> Map.get(:uuid)

  defp i_am_master?(socket) do
    %{uuid: my_uuid, members: members} = socket.assigns

    my_uuid == master_uuid(members)
  end

  defp avatar_image(n),
    do: "minion-#{n}.png"

  defp extra_heal_points(members),
    do: members |> Enum.count() |> Kernel.div(2)
end
