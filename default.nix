{
  lib,
  qtbase,
  qtquick3d,
  stdenv,
  wrapQtAppsHook,
  cmake,
clang,
  pkg-config,
  version ? "unknown",
}: stdenv.mkDerivation (finalAttrs: rec {
  pname = "fht-compositpr-qml-plugin";
  inherit version;

  src = ./.;

  inherit (qtbase) qtPluginPrefix qtQmlPrefix;
  cmakeFlags = [
    "-DINSTALL_PLUGINSDIR=${placeholder "out"}/${qtPluginPrefix}"
    "-DINSTALL_QMLDIR=${placeholder "out"}/${qtQmlPrefix}"
  ];

  nativeBuildInputs = [ wrapQtAppsHook cmake pkg-config ];
  buildInputs = [ qtbase qtquick3d ];

  meta = {
    description = "A QT6 plugin to wrap fht-compositor's IPC, made specifically for Quickshell";
    homepage = "https://github.com/nferhat/fht-compositor-qml-plugin";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})
