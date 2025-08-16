defmodule SteelEx do
  @doc ~S"""
  Initializes a Steel interpreter.

  TODO:
  - support different engine modes
  - sandboxing engine "environments" on-disk / in memory?

  ## Examples

      iex> {:ok, vm} = SteelEx.steel_init()

  """
  def steel_init() do
    raise "NYI"
  end

  @doc ~S"""
  Convenience function to evaluate a chunk of Scheme code.
  Does not allow interpolation.

  TODO:
  - any purpose for sigil modifiers?

  ## Examples

      iex> ~SCM"""
      ...> (define bar `(1 2 3))
      ...> (cadr bar)
      ...> """
      ...> "2"
  """
  def sigil_SCM(chunk, _) do
    # TODO handle vars, assignments, and errors from the engine
    # aka the rest of the owl
    SteelEx.Native.eval(chunk)
  end
end
