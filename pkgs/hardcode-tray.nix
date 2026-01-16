{ pkgs }:

let
  pythonEnv = pkgs.python3.withPackages (ps: [ ps.pygobject3 ]);
in
pkgs.stdenv.mkDerivation rec {
  pname = "hardcode-tray";
  version = "4.3";

  src = pkgs.fetchFromGitHub {
    owner = "bilelmoussaoui";
    repo = "Hardcode-Tray";
    rev = "v4.3";
    sha256 = "sha256-VY2pySi/sCqc9Mx+azj2fR3a46w+fcmPuK+jTBj9018=";
  };

  nativeBuildInputs = [
    pkgs.meson
    pkgs.ninja
    pkgs.pkg-config
    pkgs.gobject-introspection
    pkgs.makeWrapper
    pkgs.wrapGAppsHook3
  ];

  buildInputs = [
    pythonEnv
    pkgs.gtk3
    pkgs.librsvg
    pkgs.inkscape
    pkgs.imagemagick
  ];

  postInstall = ''
    wrapProgram $out/bin/hardcode-tray \
      --prefix PATH : ${pythonEnv}/bin \
      --set PYTHONPATH ${pythonEnv}/${pythonEnv.sitePackages}
  '';

  meta = with pkgs.lib; {
    description = "Fixes hardcoded tray icons in Linux.";
    homepage = "https://github.com/bilelmoussaoui/Hardcode-Tray";
    license = licenses.gpl3;
  };
}
