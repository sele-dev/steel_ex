defmodule SteelEx.Native do
  use Rustler, otp_app: :steelex, crate: "steelex"
  @moduledoc """
  Documentation for `SteelEx.Native`.
  """

  @doc ~S"""
  NIF to evaluate a given chunk of Scheme code.

  ## Examples

      iex> SteelEx.Native.eval("(define foo `(1 2 3)) (cadr foo)")
      "2"

  """
  def eval(_), do: :erlang.nif_error(:nif_not_loaded)
end
