# SteelEx
[![Hex.pm](https://img.shields.io/hexpm/v/steelex.svg?style=flat&color=blue)](https://hex.pm/packages/steelex) [![Documentation](https://img.shields.io/badge/documentation-gray)](https://hexdocs.pm/steelx)

SteelEx allows you to work with embedded [Steel Scheme](https://github.com/mattwparas/steel) in Elixir. It is heavily inspired by [pythonx](https://github.com/livebook-dev/pythonx).

## Roadmap
- Pre-Alpha versions: v0.0.X

## Development Environment Setup
This is suitable at least for use on (Fedora Kinoite)[https://fedoraproject.org/atomic-desktops/kinoite/]. (distrobox)[https://github.com/89luca89/distrobox] is useful but not required.
```bash
distrobox create --image docker.io/library/elixir:1.18.4 --name steelex
distrobox enter steelex
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
. "$HOME/.cargo/env" \
rustup default stable \
git clone https://github.com/sele-dev/steelex \
cd steelex \
mix deps.get \
mix test
```

## Related Projects
- [Steel Scheme](https://github.com/mattwparas/steel) - Embedded, extensible Scheme dialect built in Rust
- [steelex_mcp](https://github.com/sele-dev/steelex_mcp) - MCP server for Steel Scheme implemented in Elixir via SteelEx (companion project)

## License
Licensed under the Mozilla Public License 2.0 (MPL-2.0).
