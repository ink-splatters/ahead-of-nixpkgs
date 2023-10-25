{
  description = "protonmail-bridge updated ahead of nixpkgs";

  nixConfig.extra-substituters = [ https://aarch64-darwin.cachix.org ];
  nixConfig.extra-trusted-public-keys = "aarch64-darwin.cachix.org-1:mEz8A1jcJveehs/ZbZUEjXZ65Aukk9bg2kmb0zL9XDA=";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        protonmail-bridge-patched = (import ./pkgs/protonmail-bridge) { inherit pkgs; };
      in
      {

        formatter = pkgs.nixpkgs-fmt;
        packages.default = pkgs.buildEnv {
          name = "nixpkgs-edge";
          paths = # with pkgs;
            [
              protonmail-bridge-patched
            ];

        };
      }

    );
}
