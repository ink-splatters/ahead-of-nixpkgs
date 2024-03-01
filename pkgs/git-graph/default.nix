{ fenix, pkgs, ... }:
with pkgs;

let
  rustPlatform = callPackage ./rust-platform-2023-06-27;

in (git-graph.overrideAttrs (oldAttrs: {
  RUSTFLAGS =
    "-C codegen-units=1 -C embed-bitcode=yes -C lto=fat -C linker=clang -C link-arg=-fuse-ld=lld";

  nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ lld ];
  buildInputs = oldAttrs.buildInputs
    ++ [ darwin.apple_sdk.frameworks.Security ];

  allowParallelBuilding = true;

})).override {
  inherit (llvmPackages_17) stdenv;
  inherit rustPlatform;
}

