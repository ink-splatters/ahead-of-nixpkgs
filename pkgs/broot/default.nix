{ pkgs
, fetchFromGitHub
, rustPlatform
  # withClipboard? false
}:
let 
  version = "1.33.1";
in
pkgs.broot.override {
  rustPlatform.buildRustPackage = args: rustPlatform.buildRustPackage (args : {
    inherit version;
    
    src = fetchFromGitHub {
      owner = "Canop";
      repo = args.name;
      rev = "v${version}";
      hash = "sha256-k8rBf1kSeumtOHixJR9g90q+u5eIL0584fvTK/Qg/FU=";
    };

    cargoHash = "sha256-ATRtC1HUpvHId5NyMKeXWdmfM1STRB83+PioRPRC12Q=";

    RUSTFLAGS = "-C codegen-units=1 -C embed-bitcode=yes -C lto=fat -C linker=clang -C link-arg=-fuse-ld=lld";
    #-Cpanic=abort";
  });
}