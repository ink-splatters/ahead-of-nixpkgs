{ pkgs
, lib
, withPCRE2
, withSIMD
}:
let
  version = "2023-10-10+master.7099e174acbcbd940f57e4ab4913fee4040c826e";
  src = pkgs.fetchFromGitHub {
    owner = "BurntSushi";
    repo = "ripgrep";
    rev = "7099e174acbcbd940f57e4ab4913fee4040c826e";
    hash = "sha256-QlXgKcjxv/zuURhHz8f0Sc8ZDFMCiLUdxJt4s6HrpWs=";
  };

  cargoHash = "sha256-JzLi2D3AommseDKSgU2h1n23GWgWGf1N4ltVohgYHsM=";
in
  pkgs.ripgrep.override {
    rustPlatform.buildRustPackage = args: pkgs.rustPlatform.buildRustPackage (args // {

    RUSTFLAGS = "-C codegen-units=1 -C embed-bitcode=yes -C lto=fat -C linker=clang -C link-arg=-fuse-ld=lld";
    #-Cpanic=abort";
    inherit src version withPCRE2 cargoHash;


    buildFeatures = args.buildFeatures ++ lib.optional withSIMD [ "simd-accel" ];
    nativeBuildInputs = args.nativeBuildInputs ++ [ (with pkgs.llvmPackages_latest; [
       clang
       lld])  ];
    });
}
