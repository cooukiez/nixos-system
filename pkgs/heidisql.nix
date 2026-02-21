/*
  pkgs/heidisql.nix

  created by ludw
  on 2026-02-18
*/

{
  stdenv,
  lib,
  fetchurl,
  dpkg,
  autoPatchelfHook,
  makeWrapper,
  glib,
  gtk2,
  libX11,
  sqlite,
  pango,
  cairo,
  gdk-pixbuf,
  atk,
}:
stdenv.mkDerivation rec {
  pname = "heidisql";
  version = "12.15.1.1";

  src = fetchurl {
    url = "https://github.com/HeidiSQL/HeidiSQL/releases/download/v${version}/heidisql_${version}_amd64.deb";
    hash = "sha256-1woLZ+E16WPowYRzk4RYI8SXaU3sht4GNJhItaBrrr8=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    glib
    gtk2
    libX11
    sqlite
    pango
    cairo
    gdk-pixbuf
    atk
  ];

  unpackPhase = "dpkg-deb -x $src .";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/heidisql
    mkdir -p $out/bin

    if [ -d usr/share ]; then
      cp -r usr/share/* $out/share/
    fi

    # actual app files are usually in opt/heidisql or usr/lib/heidisql
    if [ -d opt/heidisql ]; then
      cp -r opt/heidisql/* $out/share/heidisql/
    elif [ -d usr/lib/heidisql ]; then
      cp -r usr/lib/heidisql/* $out/share/heidisql/
    fi

    # create our own clean wrapper script
    makeWrapper $out/share/heidisql/heidisql $out/bin/heidisql \
      --prefix LD_LIBRARY_PATH : "$out/share/heidisql" \
      --set HS_DIR "$out/share/heidisql"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Native Linux build of HeidiSQL";
    homepage = "https://www.heidisql.com/";
    license = licenses.gpl2Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = "heidisql";
  };
}
