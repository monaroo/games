defmodule Games.Wordle do
  @correct_answer Enum.random(["toast", "tarts", "hello", "beats"])
  @spec play :: [atom()]
  def play(correct_word  \\ @correct_answer) do
    user_input = IO.gets("Enter a five letter word:\n") |> String.trim()
     feedback(user_input, correct_word)
  end

  @spec feedback(binary, binary) :: [atom()]
  def feedback(correct, guess) do
    correct_chars = String.graphemes(correct)
    guess_chars = String.graphemes(guess)

    accumulator = %{correct: correct_chars, available: correct_chars, guess_letters: []}

    result =
    Enum.reduce(guess_chars, accumulator, fn letter, acc ->
      position = Enum.count(acc.guess_letters)
      # green : if the letter is correct && in the correct position
      correct = Enum.at(acc.correct, position)
      cond do
        letter == correct ->
          acc
          |> Map.update!(:available, &(&1 -- [letter]))
          |> Map.update!(:guess_letters, &([:green | &1 ]))
         # yellow: if letter is in correct but incorrect position
        letter in acc.available ->
          acc
          |> Map.update!(:available, &(&1 -- [letter]))
          |> Map.update!(:guess_letters, &([:yellow | &1]))
                 # otherwise gray
        true ->
          Map.update!(acc, :guess_letters, &([:yellow | &1]))
      end
    end)
    result.guesses
  end
end
