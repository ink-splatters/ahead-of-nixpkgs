# TODO: despite the efforts, doesn't build currently with:
# error: builder for '/nix/store/4asxsv9zazxr94jyywf865ni7q7jsiwq-micromamba-20240202.4075f0b.drv' failed with exit code 1;
#        last 10 log lines:
#        >    -> Statically linking against libmamba (static) dependencies
#        > CMake Error at cmake/Checks.cmake:9 (message):
#        >   Expected type "STATIC_LIBRARY" for target "yaml-cpp::yaml-cpp" but found
#        >   "SHARED_LIBRARY"
#        > Call Stack (most recent call first):
#        >   libmamba/CMakeLists.txt:441 (mamba_target_check_type)
#        >   libmamba/CMakeLists.txt:675 (libmamba_create_target)
#        >
#        >
{ pkgs }:
let

  version = "20240202.4075f0b";
  CFLAGS = "-O3 -mcpu=apple-m1";
  CXXFLAGS = "${CFLAGS}";
  LDFLAGS = "-fuse-ld=lld";
  inherit (pkgs) lib llvmPackages_latest;
  inherit (llvmPackages_latest) stdenv;
  inherit (lib) lists;

  yaml-cpp' = with pkgs; yaml-cpp.overrideAttrs (_: {
    cmakgFlags = lists.remove "-DYAML_BUILD_SHARED_LIBS=true" yaml-cpp.cmakeFlags ++
      [ "-DYAML_BUILD_SHARED_LIBS=false" "-DBUILD_SHARED=NO" ];
  });
in
with pkgs; (micromamba.overrideAttrs (oldAttrs: {
  inherit version CFLAGS CXXFLAGS LDFLAGS stdenv;
  yaml-cpp = yaml-cpp';

  src = fetchFromGitHub {
    inherit (oldAttrs.src) owner repo;
    rev = "4075f0b58d968e2698e8ddff410e1363c33746f8";
    hash = null; # "sha256-kWV8wAHISgzn+UDZOG1FmYdIhyqNp0P8p/mAZ8SPntrc=";
  };

  enableParallelBuilding = true;

  propagatedBuildInputs = [ stdenv ];
  nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ ninja lld simdjson pkg-config ];
  cmakeFlags = oldAttrs.cmakeFlags ++ [ "-DMAMBA_LTO=ON" ];

})).override { inherit stdenv; yaml-cpp = yaml-cpp'; }
