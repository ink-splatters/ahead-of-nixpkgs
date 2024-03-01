{
  description = "edge-shaper: nixpkgs edge package collection";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  nixConfig = {
    extra-substituters =
      "https://cachix.cachix.org https://aarch64-darwin.cachix.org ";
    extra-trusted-public-keys =
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM= aarch64-darwin.cachix.org-1:mEz8A1jcJveehs/ZbZUEjXZ65Aukk9bg2kmb0zL9XDA=";
  };

  outputs = { self, nixpkgs, fenix, flake-utils, pre-commit-hooks, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowBroken = true;
        };
        rustPlatform-2023-06-27 = callPackage ./utils/rustPlatform-2023-06-27 { };
      in with pkgs; {
        checks.pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;

          hooks = {
            deadnix.enable = true;
            markdownlint.enable = true;
            nil.enable = true;
            nixfmt.enable = true;
            statix.enable = true;
          };

          settings.markdownlint.config = {
            #MD013/line-length : Line length : https://github.com/DavidAnson/markdownlint/blob/v0.33.0/doc/md013.md
            "MD013" = {
              #Include tables
              "tables" = false;
            };
          };

          tools = pkgs;
        };

        formatter = nixfmt;

        devShells.install-hooks =
          mkShell.override { stdenv = pkgs.stdenvNoCC; } {
            inherit (self.checks.${system}.pre-commit-check) shellHook;
          };

        packages.default = let
          applyOldRustPlatform = pkg: (pkgs.callPackage ./pkgs/${pkg} { inherit fenix ; inherit rustPlatform-2023-06-27; }) ;
        in buildEnv {
          name = "nixpkgs-edge";
          paths = [
            (callPackage ./pkgs/micromamba { })
          ] ++ map applyOldRustPlatform [ "git-graph" ];
        };
      });
}
