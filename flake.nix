{
  description = "edge-shaper: nixpkgs edge package collection";

  inputs = {
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
    extra-substituters = "https://aarch64-darwin.cachix.org ";
    extra-trusted-public-keys = "aarch64-darwin.cachix.org-1:mEz8A1jcJveehs/ZbZUEjXZ65Aukk9bg2kmb0zL9XDA=";
  };

  outputs = { self, nixpkgs, flake-utils, pre-commit-hooks, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      with pkgs; {
        checks.pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;

          hooks = {
            deadnix.enable = true;
            markdownlint.enable = true;
            nil.enable = true;
            nixpkgs-fmt.enable = true;
            statix.enable = true;
          };

          settings.markdownlint.config = {
            #MD013/line-length : Line length : https://github.com/DavidAnson/markdownlint/blob/v0.33.0/doc/md013.md
            "MD013" = {
              #Include tables
              "tables" = false;
            };
          };


          # config.markdownlint = ".markdownlint.yaml";
          #   # MD013 = {
          #   #   tables = true;
          #   # };

          # };


          tools = pkgs;
        };

        formatter = nixpkgs-fmt;

        devShells.install-hooks = nixpkgs.legacyPackages.${system}.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
        };

        packages.default = buildEnv {
          name = "nixpkgs-edge";
          paths = [
            (callPackage ./pkgs/micromamba { })
          ];
        };
      });
}
