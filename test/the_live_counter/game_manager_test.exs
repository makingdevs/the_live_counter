defmodule TheLiveCounter.GameManagerTest do
  alias TheLiveCounter.GameManager
  use ExUnit.Case, async: true

  test "add a new game" do
    game = GameManager.new()
    assert game
    assert game.counter == 0
    assert game.id > 0
  end

  test "count the games" do
    GameManager.new()
    GameManager.new()
    GameManager.new()
    assert GameManager.count() >= 3
  end

  test "find a game" do
    game = GameManager.new()
    game_found = GameManager.find_game(game.id)

    assert game.id == game_found.id
  end
end
