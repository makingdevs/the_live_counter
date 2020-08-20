defmodule TheLiveCounter.GameTest do
  alias TheLiveCounter.Game
  use ExUnit.Case, async: true

  setup do
    pid_game = start_supervised!({Game, name: "game_name"})
    %{pid_game: pid_game}
  end

  test "starts a new game", %{pid_game: _pid_game} do
    assert Game.get_counter("game_name") == 0
    Game.increase_counter("game_name")
    assert Game.get_counter("game_name") == 1
  end
end
