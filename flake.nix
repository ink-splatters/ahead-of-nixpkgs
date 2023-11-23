{
  description = "edge-shaper: nixpkgs edge package collection";

  nixConfig = {
    extra-substituters = [ https://aarch64-darwin.cachix.org https://nix-community.cachix.org ];
    extra-trusted-public-keys = "aarch64-darwin.cachix.org-1:mEz8A1jcJveehs/ZbZUEjXZ65Aukk9bg2kmb0zL9XDA= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, fenix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {

          inherit system;
          overlays = [
            (final: prev: {
              rustPlatform =
                let
                  toolchain = fenix.packages.${system}.minimal.toolchain;
                in
                (prev.makeRustPlatform {
                  cargo = toolchain;
                  rustc = toolchain;
                });
            })
          ];
        };
      in
      {
        formatter = pkgs.nixpkgs-fmt;
        packages.default = pkgs.buildEnv {
          name = "nixpkgs-edge";
          paths = with pkgs; [
            (callPackage ./pkgs/ripgrep { withPCRE2 = true; withSIMD = true; })
            (callPackage ./pkgs/micromamba { })
            (callPackage ./pkgs/tectonic { })
          ];
        };
      }
    );
}
