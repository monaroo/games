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
  @spec play :: :ok
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

defmodule Games.RockPaperScissors do
  @spec play :: :ok
  def play do
    guess = IO.gets("Choose rock, paper or scissors:")
            |> String.split("\n")
            |> List.first()

    if guess in ["rock", "paper", "scissors"]  do
      do_play(guess)
    else
      play()
    end
  end
  @spec do_play(binary()) :: :ok
  defp do_play(guess) do
    rand = Enum.random(["rock", "paper", "scissors"])
      case beats({guess, rand}) do
      :win -> IO.puts("You won! #{guess} beats #{rand}!")
      :tie -> IO.puts("It's a tie!")
      :loss -> IO.puts("You lost! #{rand} beats #{guess}!")
    end
  end
  @spec beats({String.t(), String.t()}) :: :tie | :win | :loss
  defp beats({guess1, guess2}) do
    cond do
    {guess1, guess2} in [{"rock", "scissors"}, {"scissors", "paper"},{"paper", "rock"}] -> :win
    {guess1, guess1} -> :tie
    true -> :loss
    end
  end
end
