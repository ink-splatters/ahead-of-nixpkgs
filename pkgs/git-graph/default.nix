{ fenix, pkgs, ... }:
with pkgs;

let
  rustPlatform = let
    # toolchain = fenix.packages.${system}.minimal.toolchain;
    toolchain = (fenix.packages.${system}.toolchainOf {
      channel = "nightly";
      date = "2023-06-27";
      sha256 = "sha256-cEqwE1OyPc9IEzpMzEKyctZNhxAz7N+kp5OClK9NwEY=";
    }).minimalToolchain;
  in makeRustPlatform {
    cargo = toolchain;
    rustc = toolchain;
  };

in (git-graph.overrideAttrs (oldAttrs: {
  RUSTFLAGS =
    "-C codegen-units=1 -C embed-bitcode=yes -C lto=fat -C linker=clang -C link-arg=-fuse-ld=lld";

  nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ lld_17 ];
  buildInputs = oldAttrs.buildInputs
    ++ [ darwin.apple_sdk.frameworks.Security ];

  allowParallelBuilding = true;

})).override {
  inherit (llvmPackages_17) stdenv;
  inherit rustPlatform;
}

