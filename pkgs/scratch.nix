{
  lib,
  libGL,
  stdenv,
  fetchFromGitHub,
  buildNpmPackage,
  nodejs_20,
  gtk3,
  glib,
  electron,
  copyDesktopItems,
  makeDesktopItem,
  makeWrapper,
  python3,
}:

buildNpmPackage rec {
  pname = "scratch-desktop";
  version = "3.30.5";

  src = fetchFromGitHub {
    owner = "scratchfoundation";
    repo = "scratch-desktop";
    rev = "v${version}";
    hash = "sha256-0awZu2LP6WTKlM2em4Wl88mSWVXUk6N9iA0WPt56aeg=";
  };

  npmDepsHash = "sha256-JaqULkDHPrv+rgpPirBMmGbQJFbYde5yHpgL5g83BSo=";

  makeCacheWritable = true;

  env = {
    ELECTRON_SKIP_BINARY_DOWNLOAD = "1";
  };

  nodejs = nodejs_20;

  buildInputs = [
    nodejs_20
    electron
  ];

  nativeBuildInputs = [
    copyDesktopItems
    makeWrapper
  ];

  meta = with lib; {
    description = "Scratch 3.0 as a self-contained desktop application";
    homepage = "https://scratch.mit.edu/download";
    license = licenses.agpl3Only;
    platforms = [ "x86_64-linux" ];
  };
}
