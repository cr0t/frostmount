defmodule Frostmount.Presence do
  use Phoenix.Presence,
    otp_app: :frostmount,
    pubsub_server: Frostmount.PubSub
end
