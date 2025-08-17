defmodule SteelEx do
  @moduledoc """
  Helpers to facilitate work with [Steel Scheme](https://github.com/mattwparas/steel).
  """

  @doc ~S"""
  Initializes environment for a [Steel Scheme](https://github.com/mattwparas/steel) interpreter.
  At this time, we simply ensure the steel data directory exists

  ## Examples

      iex> {:ok, _path} = SteelEx.steel_init()

  """
  def steel_init() do
    # TODO:
    # - engine as an Elixir resource
    # - different engine modes
    # - sandboxing engine "environments" on-disk
    base_path = System.get_env("XDG_DATA_HOME") || default_xdg_data_home()
    full_path = base_path <>  "/steel"

    # TODO What's idiomatic here?
    case File.mkdir_p(full_path) do
      :ok -> {:ok, full_path}
      {:error, reason} ->
        IO.puts("Failed to create steel data dir: #{reason}")
        {:error, reason}
    end
  end

  defp default_xdg_data_home do
    home = System.get_env("HOME") || raise "User HOME environment variable is not set"
    Path.join(home, ".local/share")
  end

  @doc ~S"""
  Convenience function to evaluate a chunk of Scheme code.
  Does not allow interpolation.

  ## Examples

      iex> ~SCM"""
      ...> (define bar `(1 2 3))
      ...> (cadr bar)
      ...> """
      ...> {:ok, 2}
  """
  def sigil_SCM(chunk, _) do
    # TODO
    # - handle vars, assignments, and errors from the engine
    #     aka the rest of the owl
    SteelEx.steel_init()
    SteelEx.Native.eval(chunk)
  end

  # Helper to initialize the steel data dir then invoke the repl NIF
  def run_repl() do
    SteelEx.steel_init()
    SteelEx.Native.run_repl()
  end
end
