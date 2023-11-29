{ pkgs
, lib
, stdenv
}:
pkgs.opam.overrideAttrs (oldAttrs: {
  NIX_LDFLAGS = lib.optionalString (stdenv.cc.isClang && stdenv.cc.libcxx != null) " -l${stdenv.cc.libcxx.cxxabi.libName}";
})
