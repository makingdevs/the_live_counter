defmodule TheLiveCounter.GameRegistry do
  alias TheLiveCounter.Game
  use GenServer

  @supervisor TheLiveCounter.DynamicSupervisor

  ## Client API

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def create do
    GenServer.call(__MODULE__, {:create})
  end

  def lookup(id) do
    GenServer.call(__MODULE__, {:lookup, id})
  end

  def count() do
    GenServer.call(__MODULE__, {:count})
  end

  ##  GenServer Callbacks

  def init(_args) do
    {:ok, []}
  end

  def handle_call({:create}, _from, []) do
    {:reply, 0, []}
  end

  def handle_call({:count}, _from, []) do
    counter =
      @supervisor
      |> DynamicSupervisor.count_children()
      |> count_workers()

    {:reply, counter, []}
  end

  defp count_workers(%{workers: workers} = _childs), do: workers
end
