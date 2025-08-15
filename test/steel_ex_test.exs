defmodule SteelExTest do
  use ExUnit.Case
  doctest SteelEx

  test "greets the world" do
    assert SteelEx.hello() == "from rust"
  end
end
