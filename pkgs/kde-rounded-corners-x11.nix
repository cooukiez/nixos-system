{
  stdenv,
  fetchFromGitHub,
  cmake,
  kdePackages,
  libepoxy,
  libxcb,
  lib
}:

stdenv.mkDerivation rec {
  pname = "kde-rounded-corners-x11";
  version = "0.8.6";

  src = fetchFromGitHub {
    owner = "matinlotfali";
    repo = "KDE-Rounded-Corners";
    rev = "v${version}";
    hash = "sha256-v/kobtUoWBbYP4iMiUqWNnpIYyu5CBmYHnwxfN4eoQ0=";
  };

  nativeBuildInputs = [
    cmake
    kdePackages.extra-cmake-modules
    kdePackages.wrapQtAppsHook
  ];

  buildInputs = [
    kdePackages.kcmutils
    kdePackages.kwin-x11
    libepoxy
    libxcb
    kdePackages.qtbase
  ];

  # build for X11 by setting KWIN_X11=ON
  cmakeFlags = [
    "-DKWIN_X11=ON"
  ];

  meta = {
    description = "Rounds the corners of your windows";
    homepage = "https://github.com/matinlotfali/KDE-Rounded-Corners";
    license = lib.licenses.gpl3Only;
  };
}
