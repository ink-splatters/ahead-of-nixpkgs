# Edge Sharper

when the bleeding edge is not bleeding enough: opinionated collection of
`nixpkgs` packages, patched to use their latest upstream version

## Motivation

[nixpkgs](https://github.com/NixOS/nixpkgs) is massive codebase. Some packages
lag behind the latest versions of software they represent, even in
[unstable](https://nixos.org/channels/nixpkgs-unstable).

_Temporary solution_: packages get removed from this repo when their nixpkgs
version matches the upstream again. There are custom builds of some packages
which do not follow this logic.

## Installation

```shell

nix profile install github:ink-splatters/edge-sharper --accept-flake-config
```

## Packages

name | nixpkgs version |---|upstream version |mods
:---: | :---: | :---:  | :---:  | :---:
__micromamba__|[1.5.4](https://github.com/mamba-org/mamba/commit/5ce083f6cb4fb8f9a466a665954fa941f0cbb4f3)|⬆️|[1.5.8](https://github.com/mamba-org/mamba/commit/4f269258b4237a342da3e9891045cdd51debb27c)| -

## License

[MIT](LICENSE). [caveats](https://github.com/NixOS/nixpkgs#license) apply.
