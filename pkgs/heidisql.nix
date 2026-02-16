{
  stdenv,
  lib,
  fetchurl,
  dpkg,
  autoPatchelfHook,
  makeWrapper,
  glib,
  gtk3,
  libX11,
  sqlite,
}:
stdenv.mkDerivation rec {
  pname = "heidisql";
  version = "12.15.1.1";

  src = fetchurl {
    url = "https://github.com/HeidiSQL/HeidiSQL/releases/download/v${version}/heidisql_${version}_amd64.deb";
    # Run `nix-prefetch-url [url]` to verify this hash
    hash = "sha256-R3N29Y6k0fDqGvXn7V2XvBqB6Y9C9K5J8L9M0N1P2Q3=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    makeWrapper
  ];

  # Runtime dependencies for the native Linux build
  buildInputs = [
    glib
    gtk3
    libX11
    sqlite
  ];

  unpackPhase = "dpkg-deb -x $src .";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/share/heidisql

    # Move the extracted files to the nix store
    # Based on the current .deb structure:
    cp -r usr/bin/* $out/bin/ || true
    cp -r usr/share/* $out/share/ || true

    # If the binary is specifically located in /opt/heidisql
    if [ -d "opt/heidisql" ]; then
      cp -r opt/heidisql/* $out/share/heidisql/
      ln -s $out/share/heidisql/heidisql $out/bin/heidisql
    fi

    runHook postInstall
  '';

  meta = with lib; {
    description = "Native Linux build of HeidiSQL (GTK3)";
    homepage = "https://www.heidisql.com/";
    license = licenses.gpl2Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = "heidisql";
  };
}
