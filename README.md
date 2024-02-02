# Edge Sharper

when the bleeding edge is not bleeding enough: opinionated collection of nixpkgs packages, patched to use their latest upstream version

## Motivation

[nixpkgs](https://github.com/NixOS/nixpkgs) is massive codebase. Some packages lag behind the latest versions of software they represent, even in [unstable](https://nixos.org/channels/nixpkgs-unstable).

_Temporary solution_: packages get removed from this repo when their nixpkgs version matches the upstream again.

## Installation

```shell
nix profile install github:ink-splatters/edge-sharper --accept-flake-config
```

## Packages

name | nixpkgs version |---|upstream version |mods
:---: | :---: | :---:  | :---:  | :---:
__micromamba__|[1.5.6](https://github.com/mamba-org/mamba/commit/8c739ea7931aeca0a88a187a66753457aee8d078)|⬆️|[20240202-4075f0b](https://github.com/mamba-org/mamba/commit/4075f0b58d968e2698e8ddff410e1363c33746f8)|
ó

# License

[MIT](LICENSE)

Note: nixpkgs license [caveats](https://github.com/NixOS/nixpkgs#license) apply to this project as well.
