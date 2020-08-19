defmodule TheLiveCounter.Game do
  alias __MODULE__
  use Agent, restart: :temporary
  defstruct counter: 0, id: 0, name: ""

  ##  API Client

  def start_link(_opts) do
    Agent.start_link(fn -> create() end)
  end

  defp create() do
    %Game{id: System.unique_integer([:positive])}
  end

  def get_counter(pid_game) do
    Agent.get(pid_game, fn %Game{counter: counter} -> counter end)
  end

  def increase_counter(pid_game) do
    Agent.update(pid_game, fn %Game{counter: counter} = game ->
      %Game{game | counter: counter + 1}
    end)
  end
end
