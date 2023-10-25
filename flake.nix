{
  description = "protonmail-bridge updated ahead of nixpkgs";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        protonmail-bridge = pkgs.protonmail-bridge.overrideAttrs (oldAttrs: rec {
          version = "3.5.4";
          src = pkgs.fetchFromGitHub {
            owner = "ProtonMail";
            repo = "proton-bridge";
            rev = "v${version}";
            hash = "sha256-18fcbgdpl0fma864qkx2v8pvgwnjjzjq7xxh9q279dqhm4l1ynqf";
          };
          vendorHash = pkgs.lib.fakeSha256;
        });
      in
      {
        packages.default = protonmail-bridge;
      }
    );
}
