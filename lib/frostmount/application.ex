defmodule Frostmount.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    node_name = "frostmount-#{generate_uuid()}"
    redis_host = Application.fetch_env!(:frostmount, :redis_host)

    children = [
      # Start the Telemetry supervisor
      FrostmountWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub,
       name: Frostmount.PubSub,
       adapter: Phoenix.PubSub.Redis,
       host: redis_host,
       node_name: node_name},
      # Start the Presence sub-system
      Frostmount.Presence,
      # Start the Endpoint (http/https)
      FrostmountWeb.Endpoint
      # Start a worker by calling: Frostmount.Worker.start_link(arg)
      # {Frostmount.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Frostmount.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FrostmountWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp generate_uuid(), do: :uuid.get_v4() |> :uuid.uuid_to_string() |> to_string()
end
