defmodule SteelExTest do
  import SteelEx
  use ExUnit.Case
  doctest SteelEx
  doctest SteelEx.Native

  # TODO: property based testing
  describe "basic steel value conversions" do
      test "boolean values" do
        assert {:ok, true} == SteelEx.Native.eval("#t")
        assert {:ok, false} == SteelEx.Native.eval("#f")
      end

      test "integer values" do
        assert {:ok, 42} == SteelEx.Native.eval("42")
        assert {:ok, -17} == SteelEx.Native.eval("-17")
        assert {:ok, 0} == SteelEx.Native.eval("0")
      end

      test "float values" do
        {:ok, 3.14159} = SteelEx.Native.eval("3.14159")
      end

      test "string values" do
        assert {:ok, "hello world"} == SteelEx.Native.eval("\"hello world\"")
      end

      # TODO differentiate functions into native types
      test "symbols to atoms" do
        assert {:ok, :bar} == SteelEx.Native.eval("(cadr '(foo bar baz))")
      end

      # test "invalid symbols to atoms" do
      #   assert {:error, _reason} = SteelEx.Native.eval("TODO")
      # end

      # TODO look into how Rustler handles this
      test "nil" do
        assert {:ok, []} == SteelEx.Native.eval("'()")
      end

      test "complex expressions" do
        assert {:ok, 6} == SteelEx.Native.eval("(+ 1 2 3)")
        assert {:ok,
          [[1, 2, 3], [:foo, :bar, :baz], [[:turbofish, :rocks], :wooohooo], [:test]]}
          == SteelEx.Native.eval("'((1 2 3) (foo bar baz) ((turbofish rocks) wooohooo) (test))")
        assert {:ok, :hello} == SteelEx.Native.eval("'hello")
      end
    end

    describe "error handling" do
      test "invalid syntax returns error" do
        assert {:error, _reason} = SteelEx.Native.eval("(unclosed paren")
      end
    end

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
