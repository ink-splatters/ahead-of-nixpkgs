{ pkgs }:
# https://github.com/NixOS/nixpkgs/issues/86349#issuecomment-912636683
let
  version = "3.5.4";
  src = pkgs.fetchFromGitHub {
    owner = "ProtonMail";
    repo = "proton-bridge";
    rev = "v${version}";
    sha256 = "sha256-DlsfKKkQt3QETrD3g+WX0vK3L9qiT0wMUtUBettbzKE=";
  };
in
  (pkgs.protonmail-bridge.override {
    buildGoModule = args: pkgs.buildGoModule (args // {
          vendorHash = "sha256-U+ezv3f3c5GH9eTd05/nWVFMnwhizaAMjTCn9KGX1c8=";
          inherit src version;
          # TODO: by some reason ldflags needs to be overriden as well, otherwise it gets evaluated with old version
            ldflags =
    let constants = "github.com/ProtonMail/proton-bridge/v3/internal/constants"; in
    [
      "-X ${constants}.Version=${version}"
      "-X ${constants}.Revision=${src.rev}"
      "-X ${constants}.buildTime=unknown"
      "-X ${constants}.FullAppName=ProtonMailBridge" # Should be "Proton Mail Bridge", but quoting doesn't seems to work in nix's ldflags
    ];
        });
        })
