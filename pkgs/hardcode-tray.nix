/*
  pkgs/hardcode-tray.nix

  created by ludw
  on 2026-01-02
*/

{
  stdenv,
  lib,
  pkg-config,
  meson,
  ninja,
  gobject-introspection,
  gtk3,
  librsvg,
  imagemagick,
  python3,
  fetchFromGitHub,
  makeWrapper,
  wrapGAppsHook3,
  inkscape,
}:
let
  pythonEnv = python3.withPackages (ps: [ ps.pygobject3 ]);
in
stdenv.mkDerivation rec {
  pname = "hardcode-tray";
  version = "4.3";

  src = fetchFromGitHub {
    owner = "bilelmoussaoui";
    repo = "Hardcode-Tray";
    rev = "v4.3";
    sha256 = "sha256-VY2pySi/sCqc9Mx+azj2fR3a46w+fcmPuK+jTBj9018=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    gobject-introspection
    makeWrapper
    wrapGAppsHook3
  ];

  buildInputs = [
    pythonEnv
    gtk3
    librsvg
    inkscape
    imagemagick
  ];

  postInstall = ''
    wrapProgram $out/bin/hardcode-tray \
      --prefix PATH : ${pythonEnv}/bin \
      --set PYTHONPATH ${pythonEnv}/${pythonEnv.sitePackages}
  '';

  meta = with lib; {
    description = "Fixes hardcoded tray icons in Linux.";
    homepage = "https://github.com/bilelmoussaoui/Hardcode-Tray";
    license = licenses.gpl3;
  };
}
