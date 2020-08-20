defmodule TheLiveCounter.Game do
  alias __MODULE__
  use Agent, restart: :temporary
  defstruct counter: 0, id: 0, name: ""

  ##  API Client

  def start_link(opts \\ []) do
    [name: name] = opts
    Agent.start_link(fn -> create(name) end, name: via_tuple(name))
  end

  defp create(name) do
    %Game{id: System.unique_integer([:positive]), name: name}
  end

  def get_counter(name) do
    Agent.get(via_tuple(name), fn %Game{counter: counter} -> counter end)
  end

  def get(name) do
    Agent.get(via_tuple(name), & &1)
  end

  def increase_counter(name) do
    Agent.update(via_tuple(name), fn %Game{counter: counter} = game ->
      %Game{game | counter: counter + 1}
    end)
  end

  defp via_tuple(name) do
    {:via, Registry, {Registry.ViaGame, name}}
  end
end
