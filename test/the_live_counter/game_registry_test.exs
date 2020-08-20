defmodule TheLiveCounter.GameRegistryTest do
  alias TheLiveCounter.GameRegistry
  alias TheLiveCounter.Game
  use ExUnit.Case, async: true

  test "add a new game" do
    {:ok, name, pid} = GameRegistry.create()
    assert name
    assert pid
  end

  test "count the games" do
    GameRegistry.create()
    GameRegistry.create()
    GameRegistry.create()
    assert GameRegistry.count() >= 3
  end

  test "find a game" do
    {:ok, name, game_pid} = GameRegistry.create()
    game_pid_found = GameRegistry.lookup(name)
    %Game{name: name_founded} = Game.get(name)

    assert game_pid == game_pid_found
    assert name == name_founded
  end
end
