{fenix,...}:
  let
    toolchain = (fenix.packages.${system}.toolchainOf {
      channel = "nightly";
      date = "2023-06-27";
      sha256 = "sha256-cEqwE1OyPc9IEzpMzEKyctZNhxAz7N+kp5OClK9NwEY=";
    }).minimalToolchain;
  in makeRustPlatform {
    cargo = toolchain;
    rustc = toolchain;
  }