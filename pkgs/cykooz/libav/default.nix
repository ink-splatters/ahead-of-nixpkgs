{ pkgs, lib, stdenv, system, ... }:
let

  inherit (lib.lists) remove;
in (pkgs.libav_12.overrideAttrs (oldAttrs: rec {

  configureFlags = remove "--enable-avplay" oldAttrs.configureFlags;
  buildInputs = remove "SDL" oldAttrs.buildInputs;
  nativeBuildInputs = with pkgs;
    [ llvmPackages_17.bintools gnumake ] ++ oldAttrs.nativeBuildInputs;

  CFLAGS =
    lib.optionalString ("${system}" == "aarch64-darwin") "-mcpu=apple-m1";
  CXXFLAGS = "${CFLAGS}";
  LDFALGS = "-fuse-ld=lld";

})).override {
  inherit stdenv;

  mp3Support = false;
  speexSupport = false;
  theoraSupport = false;
  vorbisSupport = false;
  vpxSupport = false;
  xvidSupport = false;
  vaapiSupport = false;
  vdpauSupport = false;
}

# with import <nixpkgs> { config.allowUnsupportedSystem = true ; };
# let

#     libdrm = (pkgs.libdrm.overrideAttrs(o: {
#   nativeBuildInputs = o.nativeBuildInputs ++ [ ninja ];
#   configureFlags=[

#   ];
#     })).override {
#   inherit (pkgs.llvmPackages_17)stdenv;
#   withValgrind = false;
#     };
# in
# mkShell {
#     nativeBuidlInputs = [ libdrm ];
# }

