{ pkgs }:
# https://github.com/NixOS/nixpkgs/issues/86349#issuecomment-912636683
let
  version = "3.6.1";
  src = pkgs.fetchFromGitHub {
    owner = "ProtonMail";
    repo = "proton-bridge";
    rev = "v${version}";
    sha256 = "sha256-1Dkw30WW7bCf89I+HUAvkfmlBbl+TcOVmAfBIFnTExE=";
  };
in
pkgs.protonmail-bridge.override {
  buildGoModule = args: pkgs.buildGoModule (args // {
    vendorHash = "sha256-1mBcYVmVLTFVyYU9QuJz1JoR0wAIREC0cCQZbHMdgZU=";
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
}
