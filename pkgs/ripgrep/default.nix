{ pkgs
, lib
, withPCRE2
, withSIMD
}:
let
  version = "2024-01-05+master.6c2a550e";
  src = pkgs.fetchFromGitHub {
    owner = "BurntSushi";
    repo = "ripgrep";
    rev = "6c2a550e1ed190351707dbcb28d5085a89ac0710";
    hash = "sha256-mUIZucvmO+DkoaSisW31JiX5g5vyYevKQGIq0Ymy3AU=";
  };

  cargoHash = "sha256-ATRtC1HUpvHId5NyMKeXWdmfM1STRB83+PioRPRC12Q=";
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

    # dirty fix to emulate old ripgrep behavior where complete/_rg was pre-generated
    preFixup = ''
      installManPage $releaseDir/build/ripgrep-*/out/rg.1
      installShellCompletion $releaseDir/build/ripgrep-*/out/rg.{bash,fish}
      mkdir -p complete
      $releaseDir/rg --generate complete-zsh > complete/_rg
      installShellCompletion --zsh complete/_rg
    '';
  });
}
