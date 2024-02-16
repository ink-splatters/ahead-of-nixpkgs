{
  description = "edge-shaper: nixpkgs edge package collection";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
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

  outputs = { self, nixpkgs, flake-utils, pre-commit-hooks, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
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

        packages.default = buildEnv {
          name = "nixpkgs-edge";
          paths = [ (callPackage ./pkgs/micromamba { }) ];
        };
      });
}
