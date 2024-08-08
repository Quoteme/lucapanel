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
        flutterTooling = with pkgs; [
          flutter
          cmake
          ninja
          bear
          pkg-config
        ];
        flutterDependencies = with pkgs; [
          fontconfig
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
          pamixer
        ];
        developmentTools = with pkgs; [
          d-spy # inspecting DBUS interfaces / generating xml files for DBUS interfaces
          neocmakelsp
          cmake-lint
          cmake-format
          (pkgs.writeShellScriptBin "install-lucapanel-to-home" /*bash*/ ''
            #!/usr/bin/env bash
            echo "Installing lucapanel to $HOME/.local/bin"
            nix build
            cp ./result/bin/lucapanel $HOME/.local/bin
          '')
        ];
      in
      rec {

        defaultPackage = packages.lucapanel;
        packages.lucapanel = with pkgs; flutter322.buildFlutterApplication (rec {
          pname = "lucapanel";
          version = "0.0.1";

          nativeBuildInputs = [ pkg-config makeWrapper ];

          buildInputs = flutterDependencies;

          src = ./panel;
          autoPubspecLock = ./panel/pubspec.lock;

          preFixup = ''
            wrapProgram "$out/bin/lucapanel" \
              --prefix PATH : ${pkgs.lib.makeBinPath additionalDependencies}
          '';
        });

        devShells.default = with pkgs; (mkShell.override { stdenv = clangStdenv; } {
          nativeBuildInputs = [
            pkg-config
            clang-tools
          ];
          buildInputs = flutterTooling ++ flutterDependencies ++ additionalDependencies ++ developmentTools;
        });
      }
    );
}
