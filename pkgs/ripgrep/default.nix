{ pkgs
, lib
, withPCRE2
, withSIMD
}:
let
  version = "2023-11-21+master.a2907db2de20fd33b0bf02d9bd1375da06218865";
  src = pkgs.fetchFromGitHub {
    owner = "BurntSushi";
    repo = "ripgrep";
    rev = "a2907db2de20fd33b0bf02d9bd1375da06218865";
    hash = "sha256-KUS0azB04/TTNU754Ot+Gxj1SJQjqcT0lJCfiV3yAM0=";
  };

  cargoHash = "sha256-VED2HuqX7/BHdUtaraQ41zkhm/dxGNVmKYmaiB8VVX8=";
in
pkgs.ripgrep.override {
  rustPlatform.buildRustPackage = args: pkgs.rustPlatform.buildRustPackage (args // {

    RUSTFLAGS = "-C codegen-units=1 -C embed-bitcode=yes -C lto=fat -C linker=clang -C link-arg=-fuse-ld=lld";
    #-Cpanic=abort";
    inherit src version withPCRE2 cargoHash;


    buildFeatures = args.buildFeatures ++ lib.optional withSIMD [ "simd-accel" ];
    nativeBuildInputs = args.nativeBuildInputs ++ [
      (with pkgs.llvmPackages_latest; [
        clang
        lld
      ])
    ];
    preFixup = ''
      installManPage $releaseDir/build/ripgrep-*/out/rg.1
      installShellCompletion $releaseDir/build/ripgrep-*/out/rg.{bash,fish}
    '';

  });
}
