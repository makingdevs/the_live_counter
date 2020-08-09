defmodule TheLiveCounter.GameManager do
  alias TheLiveCounter.Game

  @supervisor TheLiveCounter.DynamicSupervisor

  def new do
    {:ok, game_pid} =
      DynamicSupervisor.start_child(
        @supervisor,
        {Agent, fn -> Game.create() end}
      )

    game_pid
  end

  def count do
    @supervisor
    |> DynamicSupervisor.count_children()
    |> count_workers()
  end

  def game_detail(game_pid) do
    game_pid
    |> Agent.get(fn game -> game end)
  end

  defp count_workers(%{workers: workers} = _childs), do: workers
end
