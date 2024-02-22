{ pkgs,
  callPackage,
  fetchFromGitHub,
  # micromamba,
  rustPlatform
}: 
let 

libheif = (callPackage ./libheif {} );
in
rustPlatform.buildRustPackage rec {

  pname = "cykooz.heif";
  version = "v1.0.0";

  src = fetchFromGitHub {
    owner = "Cykooz";
    repo = pname;
    rev = version;
    hash = "sha256-CBU1GzgWMPTVsgaPMy39VRcENw5iWRUrRpjyuGiZpPI=";
  };

  cargoHash = "sha256-ATRtC1HUpvHId5NyMKeXWdmfM1STRB83+PioRPRC12Q=";

  nativeBuildInputs = [ pkgs.maturin ];
  buildInputs = with pkgs; [ iconv pkg-config ] ++ [ libheif ];

  RUSTFLAGS = "-C linker=clang -C link-arg=-fuse-ld=lld";
  #-Cpanic=abort";
}
