{ pkgs, lib, system, ... }:
let
  mcpu = lib.optionalString ("${system}" == "aarch64-darwin") "-mcpu=apple-m1";
in with pkgs;
micromamba.overrideAttrs (oldAttrs: rec {
  version = "1.5.6";
  CFLAGS = "-O3 ${mcpu}";
  CXXFLAGS = "${CFLAGS}";
  LDFALGS = "${mcpu} -fuse-ld=lld";

  src = fetchFromGitHub {
    inherit (oldAttrs.src) owner repo;
    rev = "8c739ea7931aeca0a88a187a66753457aee8d078";
    hash = "sha256-eeOZoMtpLjfH5fya9qpLKRlAeATyv+fEv9HwHKjZlzg=";
  };

  nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ ninja lld_17 ];

  allowParallelBuilding = true;
})
# overriding stdenv causes sw_vers failing for unknown issues (likely due to sandboxing)
# })).override { inherit (llvmPackages_17) stdenv; }
