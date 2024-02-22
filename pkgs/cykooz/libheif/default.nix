{ fetchFromGitHub, llvmPackages_17, pkgs, ... }:

(pkgs.libheif.overrideAttrs (_: rec {
  version = "1.17.6";
  src = pkgs.fetchFromGitHub {
    owner = "strukturag";
    repo = "libheif";
    rev = "v${version}";
    hash = "sha256-pp+PjV/pfExLqzFE61mxliOtVAYOePh1+i1pwZxDLAM=";
  };

  cmakeFlags = [
    "-DENABLE_PLUGIN_LOADING=OFF"
    "-DWITH_DAV1D_PLUGIN:BOOL=OFF"
    "-DWITH_DAV1D_PLUGIN:BOOL=OFF"
    "-DWITH_AOM_ENCODER:BOOL=OFF"
    "-DWITH_AOM_DECODER:BOOL=OFF"
    "-DWITH_WITH_SvtEnc_PLUGIN:BOOL=OFF"
    "-DWITH_RAV1E_PLUGIN:BOOL=OFF"
    "-DWITH_JPEG_ENCODER:BOOL=OFF"
    "-DWITH_JPEG_DECODER:BOOL=OFF"
    "-DWITH_OpenJPEG_ENCODER:BOOL=OFF"
    "-DWITH_OpenJPEG_DECODER:BOOL=OFF"
    "-DWITH_FFMPEG_DECODER" # for HW acceleration: https://github.com/strukturag/libheif/blob/33e00a4ec54e6fffca3febe3054017b1b81a0c49/CMakeLists.txt#L175
    "-DWITH_LIBSHARPYUV"
    ""
  ];

  buildInputs = with pkgs; [
    libcxx
    libcxxabi

    # "-DWITH_FFMPEG_DECODER" 
    avcodec
    avutil
  ];

})).override {
  inherit (pkgs.llvmPackages_17) stdenv;

}
