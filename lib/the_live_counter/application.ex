defmodule TheLiveCounter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TheLiveCounterWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TheLiveCounter.PubSub},
      # Start the Endpoint (http/https)
      TheLiveCounterWeb.Endpoint
      # Start a worker by calling: TheLiveCounter.Worker.start_link(arg)
      # {TheLiveCounter.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TheLiveCounter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TheLiveCounterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
