{ fetchFromGitHub, llvmPackages_17,pkgs,...}:

(pkgs.libheif.overrideAttrs ( _: {
  version = "v1.17.6";
  src = pkgs.fetchFromGitHub {
    owner = "strukturag";
    repo = "libheif";
    rev = "v${version}";
    hash = "sha256-mUIZucvmO+DkoaSisW31JiX5g5vyYevKQGIq0Ymy3AU=";
  };
 
  inherit src version;
})).override {
   inherit (pkgs.llvmPackages_17) stdenv;

}
