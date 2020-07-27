defmodule TheLiveCounter.Game do
  alias __MODULE__
  defstruct counter: 0, id: 0

  def create() do
    %Game{id: System.unique_integer([:positive])}
  end

  def increase(%Game{counter: counter} = game) do
    %Game{game | counter: counter + 1}
  end
end
