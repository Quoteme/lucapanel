{
  description = "A simple panel for the xmonad-luca desktop experience";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        flutterDependencies = with pkgs; [
          flutter
          pcre2
          fontconfig
          # Dependencies for flutter
          at-spi2-core.dev
          clang
          cmake
          dart
          dbus.dev
          # flutter
          gtk3
          libdatrie
          libepoxy
          libselinux
          libsepol
          libthai
          libxkbcommon
          ninja
          pcre
          pkg-config
          util-linux.dev
          xorg.libXdmcp
          xorg.libXtst
          cairo.dev
        ];
      in
      rec {
        defaultPackage = packages.lucapanel;
        packages.lucapanel = with pkgs; stdenv.mkDerivation (finalAttrs: {
          pname = "lucapanel";
          version = "1.0";

          src = ./.;

          nativeBuildInputs = [
            makeWrapper
          ];
          buildInputs = [
            flutter
          ];
        });

        devShells.default = with pkgs; mkShell {
          buildInputs = flutterDependencies;
        };
      }
    );
}
