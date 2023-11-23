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
__ripgrep__|[13.0.0](https://github.com/BurntSushi/ripgrep/commit/af6b6c543b224d348a8876f0c06245d9ea7929c5)|⬆️|[2023-11-21+master.a2907db2](https://github.com/BurntSushi/ripgrep/commit/a2907db2de20fd33b0bf02d9bd1375da06218865)| `--withSIMD --withPCRE2`
__tectonic__|[0.14.1](https://github.com/tectonic-typesetting/tectonic/commit/0bd27896a2bb8eddd91b2b5391c9bcd8ad74da00)|🔄|-| compilation issue fixed

# License

[MIT](LICENSE)

Note: nixpkgs license [caveats](https://github.com/NixOS/nixpkgs#license) apply to this project as well.
