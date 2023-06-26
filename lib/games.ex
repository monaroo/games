defmodule Games do
  @moduledoc """
  Documentation for `Games`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Games.hello()
      :world

  """
  def hello do
    :world
  end
end

defmodule Games.GuessingGame do
  def play do
    random = Enum.random(1..10)
    do_play(5, random)
  end

  def do_play(0, random), do: IO.puts("You lose! The answer was: #{random}")

  def do_play(count_left, random) do
    {guess, _} = Integer.parse(IO.gets("Guess a number between 1 and 10:"))

    cond do
      guess == random ->
        IO.puts("Correct!")

      guess > random ->
        IO.puts("Too high!")
        do_play(count_left - 1, random)

      guess < random ->
        IO.puts("Too low!")
        do_play(count_left - 1, random)
    end
  end
end
