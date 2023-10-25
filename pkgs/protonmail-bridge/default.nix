# # { pkgs }:
# # https://github.com/NixOS/nixpkgs/issues/86349#issuecomment-912636683
# let
#   version = "3.5.4";
#   src = pkgs.fetchFromGitHub {
#     owner = "ProtonMail";
#     repo = "proton-bridge";
#     rev = "v${version}";
#     hash = "sha256-DlsfKKkQt3QETrD3g+WX0vK3L9qiT0wMUtUBettbzKE=";
#   };
# in
#   pkgs.protonmail-bridge.override {

#   buildGoModule = args: pkgs.buildGoModule (
#     args // {
#       vendorHash = "sha256-U+ezv3f3c5GH9eTd05/nWVFMnwhizaAMjTCn9KGX1c8=";
#       inherit src version;
#     }
#   );
# }




{ pkgs }:
# { pkgs }:
# https://github.com/NixOS/nixpkgs/issues/86349#issuecomment-912636683
let
  version = "3.5.4";
  src = pkgs.fetchFromGitHub {
    owner = "ProtonMail";
    repo = "proton-bridge";
    rev = "v${version}";
    hash = "sha256-DlsfKKkQt3QETrD3g+WX0vK3L9qiT0wMUtUBettbzKE=";
  };
in
pkgs.protonmail-bridge.override {

  buildGoModule = args: pkgs.buildGoModule (
    args // {
      vendorHash = "sha256-U+ezv3f3c5GH9eTd05/nWVFMnwhizaAMjTCn9KGX1c8=";
      inherit src version;
    }
  );
}
