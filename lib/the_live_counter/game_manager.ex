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
    |> game_detail()
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

  def find_game(game_id) do
    TheLiveCounter.DynamicSupervisor
    |> DynamicSupervisor.which_children()
    |> obtain_games
    |> Enum.find(fn %Game{id: id} -> id == game_id end)
  end

  defp count_workers(%{workers: workers} = _childs), do: workers

  defp obtain_games(supervised_processes) do
    for {_, process, _, _} <- supervised_processes,
        do: game_detail(process)
  end
end
