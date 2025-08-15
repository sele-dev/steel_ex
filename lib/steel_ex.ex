defmodule SteelEx do
  use Rustler, otp_app: :steelex, crate: "steelex"
  @moduledoc """
  Documentation for `SteelEx`.
  """

  @doc """
  Hello world, from rust!
  When the NIF is loaded, it will override this function.

  ## Examples

      iex> SteelEx.hello()
      "from rust"

  """
  def hello(), do: :erlang.nif_error(:nif_not_loaded)
end
