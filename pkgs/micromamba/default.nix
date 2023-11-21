{ pkgs
, fetchFromGitHub
}:

let
  version = "1.5.3";
in
pkgs.micromamba.overrideAttrs (oldAttrs: {
  inherit version;

  src = fetchFromGitHub {
    inherit (oldAttrs.src) owner repo;
    rev = "micromamba-" + version;
    hash = "sha256-/9CzcnPd1D8jSl/pfl54+8/728r+GCqWFXahl47MJ3g=";
  };
})
