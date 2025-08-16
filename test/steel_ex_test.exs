defmodule SteelExTest do
  import SteelEx
  use ExUnit.Case
  doctest SteelEx
  doctest SteelEx.Native

  test "~SCM sigil" do
    assert {:ok, 2} == sigil_SCM("(define foo `(1 2 3)) (cadr foo)", [])
  end

  # Unneeded?
  test "~SCM sigil heredoc" do
    assert {:ok, 2} == ~SCM"""
                        (define foo `(1 2 3))
                        (cadr foo)
                        """
  end
end
