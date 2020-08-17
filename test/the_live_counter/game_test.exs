defmodule TheLiveCounter.GameTest do
  alias TheLiveCounter.Game
  use ExUnit.Case, async: true

  setup do
    pid_game = start_supervised!(Game)
    %{pid_game: pid_game}
  end

  test "starts a new game", %{pid_game: pid_game} do
    assert Game.get_counter(pid_game) == 0
    Game.increase_counter(pid_game)
    assert Game.get_counter(pid_game) == 1
  end
end
