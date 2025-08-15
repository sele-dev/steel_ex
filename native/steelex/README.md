# SteelEx NIF Crate

## To build the NIF module:

- Your NIF will now build along with your project.

## To load the NIF:

```elixir
defmodule SteelEx do
  use Rustler, otp_app: :steelex, crate: "steelex"

  # When your NIF is loaded, it will override this function.
  def hello, do: :erlang.nif_error(:nif_not_loaded)
end
```

## Examples

[This](https://github.com/rusterlium/NifIo) is a complete example of a NIF written in Rust.
