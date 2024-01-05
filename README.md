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
__ripgrep__|[14.0.3](https://github.com/BurntSushi/ripgrep/commit/67ad9917ad40d23df054b87a38532b06f85205dd)|⬆️|[2024-01-05+master.6c2a550e](https://github.com/BurntSushi/ripgrep/commit/6c2a550e1ed190351707dbcb28d5085a89ac0710)| `--withSIMD --withPCRE2`

# License

[MIT](LICENSE)

Note: nixpkgs license [caveats](https://github.com/NixOS/nixpkgs#license) apply to this project as well.
