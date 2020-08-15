defmodule TheLiveCounter.GameTest do
  use ExUnit.Case, async: true

  setup do
    pid_game = start_supervised!(TheLiveCounter.Game)
    %{pid_game: pid_game}
  end

  test "starts a new game", %{pid_game: pid_game} do
    assert TheLiveCounter.Game.get_counter(pid_game) == 0
    TheLiveCounter.Game.increase_counter(pid_game)
    assert TheLiveCounter.Game.get_counter(pid_game) == 1
  end
end
