defmodule SteelExTest do
  import SteelEx
  use ExUnit.Case
  doctest SteelEx.Native
  doctest SteelEx

  test "hello from rust" do
    assert SteelEx.Native.hello_from_rust() == "from rust"
  end

  # ref https://github.com/rusterlium/rustler/blob/05f79740eb986cf9c338d2f3d96ebf95b35ad124/rustler/src/types/mod.rs#L122
  test "hello from scheme" do
    assert SteelEx.Native.hello_from_scheme == "from scheme"
  end

  test "~SCM sigil" do
    assert sigil_SCM("(define foo `(1 2 3)) (cadr foo)", []) == "2"
  end

  test "~SCM sigil heredoc" do
    assert ~SCM"""
      (define foo `(1 2 3))
      (cadr foo)
    """ == "2"
  end
end
