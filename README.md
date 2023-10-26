# Edge Sharper

when the bleeding edge is not bleeding enough: opinionated collection of nixpkgs packages, patched to use their latest upstream version

## Motivation

[nixpkgs](https://github.com/NixOS/nixpkgs) is massive codebase. Some nix packages lag behind their official releases, even in [unstable](https://nixos.org/channels/nixpkgs-unstable) channel;
so here come a few receipts - for packages used by the author, which bump up their `nixpkgs` version.

### Why not PR?

Those come in parallel: PRs are not merged immediately; that's the reason this repo appeared.

### Temporary

Should the lag with upstream cease to exist, for a given nixpkgs package, the corresponding receipt will be removed from this repo.

## Installation

using `nix profile`:

```shell
nix profile install github:ink-splatters/edge-sharper --accept-flake-config

```

## Packages

Name | nixpkgs version |---|upstream version
:---: | :---: | :---:  | :---:
__protonmail-bridge__|[3.5.1](https://github.com/NixOS/nixpkgs/commit/6318c126bf4f3a9293d1cc9ca55ff7cc340329af)| ⬆️ | [3.5.4](https://github.com/ProtonMail/proton-bridge/releases/tag/v3.5.4)
TODO

# License

[MIT](LICENSE)

Note: nixpkgs license [caveats](https://github.com/NixOS/nixpkgs#license) apply to this project as well.
