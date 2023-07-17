defmodule Frostmount.Dispatcher do
  alias Frostmount.PubSub, as: FrostPubSub
  alias Frostmount.Presence

  @topic "frostmount:game"

  def subscribe(uuid, hero) do
    presence_meta = %{
      uuid: uuid,
      name: hero.name,
      avatar_n: hero.avatar,
      strength: hero.strength,
      joined_at: DateTime.utc_now()
    }

    {:ok, _} = Presence.track(self(), @topic, uuid, presence_meta)
    :ok = Phoenix.PubSub.subscribe(FrostPubSub, @topic)
  end

  def presence_list(),
    do: Presence.list(@topic)

  def broadcast(msg),
    do: Phoenix.PubSub.broadcast(FrostPubSub, @topic, msg)
end
