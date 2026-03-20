{
  stdenv,
  lib,
  fetchurl,
  dpkg,
  autoPatchelfHook,
  makeWrapper,
  glib,
  openssl,
  libusb1,
  usbmuxd,
  libimobiledevice,
  gtk3,
  webkitgtk_4_1,
  libsoup_3,
  cairo,
  gdk-pixbuf,
  pango,
  atk,
}:

stdenv.mkDerivation rec {
  pname = "iloader";
  version = "2.0.9";

  src = fetchurl {
    url = "https://github.com/nab138/iloader/releases/download/v${version}/iloader-linux-amd64.deb";
    hash = "sha256-MoC+NVdzMml9t6WzIm0A5GgPrqX1ohAR552XkpQT6iI=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    glib
    openssl
    libusb1
    usbmuxd
    libimobiledevice
    gtk3
    webkitgtk_4_1
    libsoup_3
    cairo
    gdk-pixbuf
    pango
    atk
  ];

  unpackPhase = "dpkg-deb -x $src .";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/share/iloader

    if [ -d usr/bin ]; then
      cp -r usr/bin/* $out/bin/
    fi

    if [ -d usr/lib ]; then
      cp -r usr/lib $out/
    fi

    if [ -d usr/share ]; then
      cp -r usr/share/* $out/share/
    fi

    runHook postInstall
  '';

  meta = with lib; {
    description = "A tool for interacting with iOS devices";
    homepage = "https://github.com/nab138/iloader";
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
    mainProgram = "iloader";
  };
}
