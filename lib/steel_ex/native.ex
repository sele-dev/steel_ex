defmodule SteelEx.Native do
  use Rustler, otp_app: :steelex, crate: "steelex"
  @moduledoc """
  Documentation for `SteelEx.Native`.
  """

  @doc """
  Hello world, from rust!
  When the NIF is loaded, it will override this function.

  ## Examples

      iex> SteelEx.Native.hello_from_rust()
      "from rust"

  """
  def hello_from_rust(), do: :erlang.nif_error(:nif_not_loaded)

  def hello_from_scheme(), do: :erlang.nif_error(:nif_not_loaded)
end
