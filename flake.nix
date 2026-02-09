{
  description = "A QML plugin to integrate fht-compositor's IPC in Qt, made for Quickshell.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = {self, nixpkgs}: let
    supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
    version = self.shortRev or self.dirtyShortRev or "unknown";
    forAllSystems = f:
      nixpkgs.lib.genAttrs supportedSystems (system: f system);
  in {
    # FIXME: Add a devShell if I feel like working on this plugin seriously.
    # Ardox did quite a good job, so I don't think it will be anytime soon, hopefully.
    packages = forAllSystems (system: let
      pkgs = import nixpkgs { inherit system; };
    in rec {
      default = fht-compositor-qml-plugin;
      fht-compositor-qml-plugin = pkgs.qt6.callPackage ./default.nix {inherit version;};
    });

    overlays.default = final: _: {
      fht-compositor-qml-plugin = final.qt6.callPackage ./default.nix {inherit version;};
    };
  };
}
