defmodule TheLiveCounter.GameRegistryTest do
  alias TheLiveCounter.GameRegistry
  alias TheLiveCounter.Game
  use ExUnit.Case, async: true

  test "add a new game" do
    game = GameRegistry.create()
    assert game
  end

  test "count the games" do
    GameRegistry.create()
    GameRegistry.create()
    GameRegistry.create()
    assert GameRegistry.count() >= 3
  end

  test "find a game" do
    game_pid = GameRegistry.create()
    %Game{name: name_created} = Game.get(game_pid)
    game_found = GameRegistry.lookup(name_created)
    %Game{name: name_founded} = Game.get(game_found)

    assert name_created == name_founded
  end
end
