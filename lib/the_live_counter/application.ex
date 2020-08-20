defmodule TheLiveCounter.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      TheLiveCounterWeb.Telemetry,
      {Phoenix.PubSub, name: TheLiveCounter.PubSub},
      TheLiveCounterWeb.Endpoint,
      {DynamicSupervisor, strategy: :one_for_one, name: TheLiveCounter.DynamicSupervisor},
      TheLiveCounter.GameRegistry,
      {Registry, keys: :unique, name: Registry.ViaGame}
    ]

    opts = [strategy: :one_for_one, name: TheLiveCounter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    TheLiveCounterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
