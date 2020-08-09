defmodule TheLiveCounter.GameManagerTest do
  alias TheLiveCounter.GameManager
  use ExUnit.Case, async: true

  test "add a new game" do
    game_pid = GameManager.new()
    assert game_pid
  end

  test "count the games" do
    GameManager.new()
    GameManager.new()
    GameManager.new()
    assert GameManager.count() >= 3
  end

  test "get game detail" do
    game_pid = GameManager.new()
    game = GameManager.game_detail(game_pid)
    assert game.counter == 0
    assert game.id > 0
  end
end
