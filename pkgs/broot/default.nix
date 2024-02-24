{ pkgs
, lib
, withPCRE2
, withSIMD
}:

pkgs.ripgrep.override {
  rustPlatform.buildRustPackage = args: pkgs.rustPlatform.buildRustPackage (args // rec {

    version = "1.33.1";

    src = fetchFromGitHub {
      owner = "Canop";
      repo = pname;
      rev = "v${version}";
      hash = "sha256-k8rBf1kSeumtOHixJR9g90q+u5eIL0584fvTK/Qg/FU=";
    };

    cargoHash = "sha256-ATRtC1HUpvHId5NyMKeXWdmfM1STRB83+PioRPRC12Q=";

    RUSTFLAGS = "-C codegen-units=1 -C embed-bitcode=yes -C lto=fat -C linker=clang -C link-arg=-fuse-ld=lld";
    #-Cpanic=abort";
  });
}
