{ pkgs
, fetchFromGitHub
, ninja
}:

let
  version = "1.5.6";
in
pkgs.micromamba.overrideAttrs (oldAttrs: {
  inherit version;

  nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ ninja ];

  src = fetchFromGitHub {
    inherit (oldAttrs.src) owner repo;
    rev = "micromamba-" + version;
    hash = "sha256-eeOZoMtpLjfH5fya9qpLKRlAeATyv+fEv9HwHKjZlzg=";
  };

  enableParallelBuilding = true;

})
