defmodule SweatherTest do
  use ExUnit.Case
  doctest Sweather

  test "greets the world" do
    assert Sweather.hello() == :world
  end
end
