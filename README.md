# Edge Sharper

when the bleeding edge is not bleeding enough: opinionated collection of nixpkgs packages, patched to use their latest upstream version

## Motivation

[nixpkgs](https://github.com/NixOS/nixpkgs) is massive codebase. Some packages lag behind the latest versions of software they represent, even in [unstable](https://nixos.org/channels/nixpkgs-unstable).

_Temporary solution_: packages get removed from this repo when their nixpkgs version matches the upstream again.

## Installation

using `nix profile`:

```shell
nix profile install github:ink-splatters/edge-sharper --accept-flake-config
```

## Packages

name | nixpkgs version |---|upstream version |mods
:---: | :---: | :---:  | :---:  | :---:
__micromamba__|[1.4.4](https://github.com/mamba-org/mamba/archive/micromamba-1.4.4.tar.gz)|⬆️|[1.5.3](https://github.com/mamba-org/mamba/commit/91c41db53394f8425094554dfabc301bc040337a) [drv input](https://github.com/mamba-org/mamba/archive/micromamba-1.5.3.tar.gz)|
__ripgrep__|[13.0.0](https://github.com/BurntSushi/ripgrep/commit/af6b6c543b224d348a8876f0c06245d9ea7929c5)|⬆️|[2023-10-10+master.7099e17](https://github.com/BurntSushi/ripgrep/commit/7099e174acbcbd940f57e4ab4913fee4040c826e)| `--withSIMD --withPCRE2`

# License

[MIT](LICENSE)

Note: nixpkgs license [caveats](https://github.com/NixOS/nixpkgs#license) apply to this project as well.
