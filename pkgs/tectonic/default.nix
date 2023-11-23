{ pkgs
, lib
, stdenv
}:
pkgs.tectonic.override {
  rustPlatform.buildRustPackage = args: pkgs.rustPlatform.buildRustPackage (args // {
    NIX_LDFLAGS = lib.optionalString (stdenv.cc.isClang && stdenv.cc.libcxx != null) " -l${stdenv.cc.libcxx.cxxabi.libName}";
  });
}
