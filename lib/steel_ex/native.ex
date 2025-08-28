defmodule SteelEx.Native do
  use Rustler, otp_app: :steel_ex, crate: "steel_ex"
  @moduledoc """
  NIFs to facilitate work with [Steel Scheme](https://github.com/mattwparas/steel).
  """

  @doc ~S"""
  NIF to evaluate a given chunk of Scheme code.

  ## Examples

      iex> {:ok, 2} = SteelEx.Native.eval_to_result("(define foo `(1 2 3)) (cadr foo)")

  """
  def eval_to_result(_), do: :erlang.nif_error(:nif_not_loaded)
  
  def eval_to_root_bindings(_), do: :erlang.nif_error(:nif_not_loaded)

  # TODO: test in Elixir or Rust? Indirectly feed ctrl+d or (quit) ?
  def run_repl(), do: :erlang.nif_error(:nif_not_loaded)
end
