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

  outputs = { nixpkgs, fenix, flake-utils, pre-commit-hooks, self, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowBroken = true;
        };
      in with pkgs; {
        checks.pre-commit-check =
          import ./utils/checks.nix { inherit pkgs pre-commit-hooks system; };

        formatter = nixfmt;

        devShells = {
          install-hooks = mkShell.override { stdenv = pkgs.stdenvNoCC; } {
            inherit (self.checks.${system}.pre-commit-check) shellHook;
          };
        };

        packages = {
          micromamba = callPackage ./pkgs/micromamba { };
          git-graph = callPackage ./pkgs/git-graph { inherit fenix; };

          default = buildEnv {
            name = "nixpkgs-edge";
            paths = [ micromamba git-graph ];
          };
        };

      });
}
