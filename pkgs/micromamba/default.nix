{ pkgs, stdenv }:

let
  version = "1.5.3";
  src = pkgs.fetchFromGitHub {
    owner = "mamba-org";
    repo = "mamba";
    rev = "micromamba-" + version;
    hash = "sha256-Z6hED0fiXzEKpVm8tUBR9ynqWCvHGXkXHzAXbbWlq9Y=";
  };
in
pkgs.micromamba.overrideAttrs(oldAttrs:  {
  stdenv.mkDerivation = oldAttrs.stdenv.makeDerivation // rec {
    inherit version src;
  };
    # stdenv.mkDerivation  =  args: stdenv.mkDerivation ( args // rec {
    #     inherit version src;
    #   });
  })
