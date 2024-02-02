{ pkgs
, fetchFromGitHub
}:

with pkgs; micromamba.overrideAttrs (oldAttrs: rec {
  version = "1.5.6";
  # CFLAGS = "-O3";
  # CXXFLAGS = "-O3";

  src = fetchFromGitHub {
    inherit (oldAttrs.src) owner repo;
    rev = "8c739ea7931aeca0a88a187a66753457aee8d078";
    hash = "sha256-eeOZoMtpLjfH5fya9qpLKRlAeATyv+fEv9HwHKjZlzg=";
  };

  # nativeBuildInputs =  oldAttrs.nativeBuildInputs ++  [ ninja ];
})
