{ fetchFromGitHub, llvmPackages_17,pkgs,...}:

(pkgs.libheif.overrideAttrs ( _:  rec {
  version = "1.17.6";
  src = pkgs.fetchFromGitHub {
    owner = "strukturag";
    repo = "libheif";
    rev = "v${version}";
    hash = "sha256-pp+PjV/pfExLqzFE61mxliOtVAYOePh1+i1pwZxDLAM=";
  };
})).override {
   inherit (pkgs.llvmPackages_17) stdenv;

}
