defmodule SteelExTest do
  import SteelEx
  use ExUnit.Case
  doctest SteelEx.Native
  doctest SteelEx

  test "~SCM sigil" do
    assert sigil_SCM("(define foo `(1 2 3)) (cadr foo)", []) == "2"
  end

  # Unneeded?
  test "~SCM sigil heredoc" do
    assert ~SCM"""
      (define foo `(1 2 3))
      (cadr foo)
    """ == "2"
  end
end
