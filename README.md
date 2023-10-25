# Edge Sharper

when the bleeding edge is not bleeding enough: opinionated collection of nixpkgs packages, patched to use their latest upstream version

## Motivation

[nixpkgs](https://github.com/NixOS/nixpkgs) is massive codebase. Some nix packages lag behind their official releases, even in [unstable](https://nixos.org/channels/nixpkgs-unstable) channel;
so here come a few receipts - for packages used by the author, which bump up their `nixpkgs` version.

### Why not PR?

Those come in parallel: PRs are not merged immediately; that's the reason this repo appeared.

### Temporary

Should the lag of a a given `nixpkgs` package cease to exist, the corresponding receipt will be removed from this repo. No more lags? The repo will be ditched alltogether (archived).

## Installation

using `nix profile`:

```shell
nix profile install github:ink-splatters/edge-shaper#latest

```

### Packages


### proton-bridge

TODO
