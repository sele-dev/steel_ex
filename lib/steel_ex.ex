defmodule SteelEx do
  def hellos() do
    SteelEx.Native.hello_from_rust()
    |> IO.puts()

    SteelEx.Native.hello_from_scheme()
    |> IO.puts()
  end
end
