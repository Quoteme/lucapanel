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
          cmake
          ninja
          bear
          fontconfig
          pkg-config
          # Dependencies for flutter
          glib
          at-spi2-core.dev
          dbus.dev
          # flutter
          gtk3.dev
          libdatrie.dev
          libepoxy.dev
          libselinux.dev
          libsepol.dev
          libthai.dev
          libxkbcommon.dev
          pcre.dev
          pcre2.dev
          util-linux.dev
          xorg.libXdmcp.dev
          xorg.libXtst
          cairo.dev
          lerc.dev
        ];
        additionalDependencies = with pkgs; [
          brightnessctl
          wmctrl
        ];
      in
      rec {

        defaultPackage = packages.lucapanel;
        packages.lucapanel = with pkgs; clangStdenv.mkDerivation (finalAttrs: {
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

        devShells.default = with pkgs; (mkShell.override { stdenv = clangStdenv; } {
          nativeBuildInputs = [
            pkg-config
            clang-tools
          ];
          buildInputs = flutterDependencies ++ additionalDependencies;
        });
      }
    );
}
