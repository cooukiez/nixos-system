{ stdenv, fetchFromGitHub, meson, ninja, pkg-config
, python3, python3Packages, gtk3, librsvg, inkscape, imagemagick }:

stdenv.mkDerivation rec {
  pname = "hardcode-tray";
  version = "4.3";

  src = fetchFromGitHub {
    owner = "bilelmoussaoui";
    repo = "Hardcode-Tray";
    rev = "v4.3";
    sha256 = "0000000000000000000000000000000000000000000000000000"; # placeholder, replace after first build
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [
    python3
    python3Packages.pygobject
    gtk3
    librsvg
    inkscape
    imagemagick
  ];

  buildPhase = ''
    meson setup builddir --prefix=$out
    ninja -C builddir
  '';

  installPhase = ''
    ninja -C builddir install
  '';

  meta = with stdenv.lib; {
    description = "Fixes hardcoded tray icons in Linux.";
    homepage = "https://github.com/bilelmoussaoui/Hardcode-Tray";
    license = licenses.gpl3;
    maintainers = with maintainers; [ ];
  };
}
