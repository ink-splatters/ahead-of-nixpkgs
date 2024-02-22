{ fetchFromGitHub, stdenv, pkgs, ... }:

stdenv.mkDerivation rec {
  pname = "libheif";
  version = "1.17.6";
  src = pkgs.fetchFromGitHub {
    owner = "strukturag";
    repo = "libheif";
    rev = "v${version}";
    hash = "sha256-pp+PjV/pfExLqzFE61mxliOtVAYOePh1+i1pwZxDLAM=";
  };

  outputs = [ "bin" "out" "dev" "man" ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DBUILD_SHARED_LIBS=ON"
    "-DBUILD_TESTING=OFF"

    "-DENABLE_PLUGIN_LOADING=OFF"
    "-DWITH_AOM_DECODER=OFF"
    "-DWITH_AOM_ENCODER=OFF"
    "-DWITH_DAV1D=OFF"
    "-DWITH_LIBDE265=ON"
    "-DWITH_RAV1E=OFF"
    "-DWITH_SvtEnc=OFF"
    "-DWITH_X265=ON"
    "-DWITH_JPEG_DECODER=OFF"
    "-DWITH_JPEG_ENCODER=OFF"
    "-DWITH_UNCOMPRESSED_CODEC=OFF"
    "-DWITH_KVAZAAR=OFF"
    "-DWITH_OpenJPEG_DECODER=OFF"
    "-DWITH_OpenJPEG_ENCODER=OFF"
    "-DWITH_FFMPEG_DECODER=OFF"

    "-DWITH_REDUCED_VISIBILITY=ON"
    "-DWITH_DEFLATE_HEADER_COMPRESSION=OFF"
    "-DWITH_LIBSHARPYUV=ON"
    "-DWITH_EXAMPLES=OFF"
    "-DWITH_FUZZERS=OFF"

    # "-DWITH_FFMPEG_DECODER" # for HW acceleration: https://github.com/strukturag/libheif/blob/33e00a4ec54e6fffca3febe3054017b1b81a0c49/CMakeLists.txt#L175
  ];

  buildInputs = with pkgs; [
    libcxx
    libcxxabi
    libde265
    x265

  ];
  naitveBuildInputs = with pkgs; [
    cmake
    ninja
    pkg-config
    llvmPackages_17.bintools
  ];

  CFLAGS = "-mcpu=apple-m1";
  CXXFLAGS = "${CFLAGS}";
  LDFLAGS = "-fuse-ld=lld";

  enableParallelBuilding = true;

}
