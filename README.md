# SteelEx
[![Hex.pm](https://img.shields.io/hexpm/v/steel_ex.svg?style=flat&color=blue)](https://hex.pm/packages/steel_ex) [![Documentation](https://img.shields.io/badge/documentation-gray)](https://hexdocs.pm/steel_ex)

SteelEx allows you to work with embedded [Steel Scheme](https://github.com/mattwparas/steel) in Elixir. It is heavily inspired by [pythonx](https://github.com/livebook-dev/pythonx).

## Roadmap
- Pre-Alpha versions: v0.0.X

## Installation
The library is available at [hex](https://hex.pm/packages/steel_ex) but currently doesn't include pre-compiled NIFs, so Rust is required to compile the library locally. It can be installed by adding `steel_ex` to your dependencies list in `mix.exs`:

```elixir
def deps do
  [
    {:steel_ex, "~> 0.0.1"}
  ]
end
```

If using [livebook](https://livebook.dev/), install it at the top of your notebook:

```elixir
Mix.install([
  {:steel_ex, "~> 0.0.1"}
])
# => :ok
```

## Usage
The `~SCM` sigil is provided to embed Scheme code within Elixir. Currently the last result of evaluating the scheme code will be passed back into the BEAM. See the docs on [hexdocs](https://hexdocs.pm/steel_ex).
```elixir
import SteelEx

~SCM"""
(cadr '(1 2 3))
"""
# => {:ok, 2}
```

## Development Environment Setup
This is suitable at least for use on [Fedora Kinoite](https://fedoraproject.org/atomic-desktops/kinoite/). [distrobox](https://github.com/89luca89/distrobox) is useful but not required.
```bash
distrobox create --image docker.io/library/elixir:1.18.4 --name steel_ex
distrobox enter steel_ex
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
. "$HOME/.cargo/env" \
rustup default stable \
git clone https://github.com/sele-dev/steel_ex \
cd steel_ex \
mix deps.get \
mix test
```

## Related Projects
- [Steel Scheme](https://github.com/mattwparas/steel) - Embedded, extensible Scheme dialect built in Rust
- [steel_ex_mcp](https://github.com/sele-dev/steel_ex_mcp) - MCP server providing Steel Scheme tools

## License
Licensed under the Mozilla Public License 2.0 (MPL-2.0).
