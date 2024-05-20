defmodule ElixirCalculatorTest do
  use ExUnit.Case
  doctest ElixirCalculator

  test "greets the world" do
    assert ElixirCalculator.hello() == :world
  end
end
