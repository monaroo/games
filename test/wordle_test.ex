defmodule WordlePlayTest do
  use ExUnit.Case

  test "feedback/2 when all letters are correct" do
    assert Games.Wordle.feedback("funny", "funny") == [:green, :green, :green, :green, :green]
  end

  test "feedback/2 when all letters are in word" do
    assert Games.Wordle.feedback("redob", "bored") == [:yellow, :yellow, :yellow, :yellow, :yellow]
  end

  test "feedback/2 when all letters are incorrect" do
    assert Games.Wordle.feedback("funny", "bored") == [:gray, :gray, :gray, :gray, :gray]
  end

  test "feedback/2 mix of gray and yellow" do
    assert Games.Wordle.feedback("bored", "arbor") == [:gray, :yellow, :yellow, :yellow, :gray]
  end

  test "feedback/2 mix of all colors" do
    assert Games.Wordle.feedback("aaabb", "xaaaa") == [:gray, :green, :green, :yellow, :gray]
  end

  test "feedback/2 multiple yellows same character" do
    assert Games.Wordle.feedback("xxcaa", "aacxx") == [:yellow, :yellow, :green, :yellow, :yellow]
  end
end
