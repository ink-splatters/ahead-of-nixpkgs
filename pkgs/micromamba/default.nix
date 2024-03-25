{ pkgs, lib, lld_17, ninja, system, ... }:
let
  mcpu = lib.optionalString ("${system}" == "aarch64-darwin") "-mcpu=apple-m1";
  CFLAGS = "-O3 ${mcpu}";
  CXXFLAGS = "${CFLAGS}";
  LDFLAGS = "${mcpu} -fuse-ld=lld -flto=full";
  version = "1.5.8";
in (pkgs.micromamba.overrideAttrs (oldAttrs: {
  inherit version;

  inherit CFLAGS CXXFLAGS LDFLAGS;

  nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ ninja lld_17 ];

  allowParallelBuilding = true;
})).override {
  # overriding stdenv causes sw_vers failing for unknown issues (likely due to sandboxing)
  # inherit (llvmPackages_17) stdenv;
  fetchFromGitHub = { owner, repo, ... }:
    pkgs.fetchFromGitHub {
      inherit owner repo;
      rev = "micromamba-" + version;
      hash = "sha256-sxZDlMFoMLq2EAzwBVO++xvU1C30JoIoZXEX/sqkXS0=";
    };
}
