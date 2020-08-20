defmodule TheLiveCounter.Game do
  alias __MODULE__
  use Agent, restart: :temporary
  defstruct counter: 0, id: 0, name: ""

  ##  API Client

  def start_link(opts \\ []) do
    ### ¿¿¿???
    [name: {:via, _, {_, game_name}}] = opts
    Agent.start_link(fn -> create(game_name) end, opts)
  end

  defp create(name) do
    %Game{id: System.unique_integer([:positive]), name: name}
  end

  def get_counter(pid_game) do
    Agent.get(pid_game, fn %Game{counter: counter} -> counter end)
  end

  def get(pid_game) do
    Agent.get(pid_game, & &1)
  end

  def increase_counter(pid_game) do
    Agent.update(pid_game, fn %Game{counter: counter} = game ->
      %Game{game | counter: counter + 1}
    end)
  end
end
