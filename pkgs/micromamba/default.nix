{ fetchFromGitHub, lib, lld_17, micromamba, ninja, system, ... }:
let
  mcpu = lib.optionalString ("${system}" == "aarch64-darwin") "-mcpu=apple-m1";
  CFLAGS = "-O3 ${mcpu}";
  CXXFLAGS = "${CFLAGS}";
  LDFLAGS = "-fuse-ld=lld -flto=full";
  version = "1.5.8";
in (micromamba.overrideAttrs (oldAttrs: {
  inherit version;
  
  src = fetchFromGitHub {
    owner = "mamba-org";
    repo = "mamba";
    rev = "micromamba-" + version;
  };

  inherit CFLAGS CXXFLAGS LDFLAGS;

  nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ ninja lld_17 ];

  allowParallelBuilding = true;
}))
# .override {
# overriding stdenv causes sw_vers failing for unknown issues (likely due to sandboxing)
# inherit (llvmPackages_17) stdenv;
