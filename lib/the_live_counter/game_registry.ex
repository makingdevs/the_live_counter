defmodule TheLiveCounter.GameRegistry do
  alias TheLiveCounter.Game
  use GenServer

  @supervisor TheLiveCounter.DynamicSupervisor

  ## Client API

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], [name: __MODULE__] ++ opts)
  end

  def create do
    GenServer.call(__MODULE__, {:create})
  end

  def lookup(name) do
    case Registry.lookup(Registry.ViaGame, name) do
      [{pid_game, _}] -> pid_game
      [] -> nil
    end
  end

  def count() do
    GenServer.call(__MODULE__, {:count})
  end

  ##  GenServer Callbacks

  def init(_args) do
    {:ok, []}
  end

  def handle_call({:create}, _from, []) do
    name = random_name()
    {:ok, game_pid} = DynamicSupervisor.start_child(@supervisor, {Game, name: name})
    {:reply, {:ok, name, game_pid}, []}
  end

  def handle_call({:count}, _from, []) do
    counter =
      @supervisor
      |> DynamicSupervisor.count_children()
      |> count_workers()

    {:reply, counter, []}
  end

  defp count_workers(%{workers: workers} = _childs), do: workers

  defp random_name() do
    ?a..?z
    |> Enum.take_random(6)
    |> List.to_string()
  end
end
