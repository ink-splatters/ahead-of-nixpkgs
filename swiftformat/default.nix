# this declares xcode-less build of swiftformat
{ pkgs,
  stdenv,
}:
let 
    src = builtins.fetchTree {
      shallow = true;
      type = "git";
      url="https://github.com/nicklockwood/SwiftFormat";
      owner = "nicklockwood";
      repo = "SwiftFormat";
      sha256 = "1gqxpymbhpmap0i2blg9akarlql4mkzv45l4i212gsxcs991b939";
    };

in 
pkgs.swiftformat.overrideAttrs (oldAttrs: {
    # inherit stdenv;
    src = src // {
      ref = oldAttrs.${version};
    };
    preConfigure=null;

    nativeBuildInputs = with pkgs;[
      swift
      swiftpm
      swiftPackages.Foundation
      darwin.apple_sdk.frameworks.AppKit
    ];

    buildPhase = ''
    swift build --configuration release
  '';

  })