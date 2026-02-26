# pkgs/gamemaker.nix

{
  stdenv,
  lib,
  fetchurl,
  dpkg,
  autoPatchelfHook,
  makeWrapper,

  # --- Libraries required by autoPatchelfHook ---
  xorg,
  openal,
  libGL,
  libGLU,
  fuse,
  curl,
  freetype,
  gtk3,
  libpulseaudio,
  zlib,
  gmp,
  e2fsprogs,
  libgpg-error,
  libpng,
  brotli,
  icu,
  openssl,

  # --- Runtime binaries required in PATH ---
  openssh,
  util-linux,
  file,
  procps,
  xdg-utils,
  gnumake,
  binutils,
  patchelf,
  squashfsTools,
  desktop-file-utils,
  zsync,
  bash,
  ffmpeg,
  unzip,
  zip,
  linuxdeploy,
  appimage-run,
}:

let
  runtimePackages = [
    openssh
    util-linux
    file
    procps
    xdg-utils
    gnumake
    binutils
    patchelf
    squashfsTools
    desktop-file-utils
    zsync
    bash
    ffmpeg
    unzip
    zip
    linuxdeploy
    appimage-run
  ];
in
stdenv.mkDerivation rec {
  pname = "gamemaker-beta";
  version = "2024.1400.4.1003";

  src = fetchurl {
    url = "https://gms.yoyogames.com/GameMaker-Beta-${version}.deb";
    # You will need to generate the hash for .1003
    # Run: nix hash to-sri --type sha256 $(nix-prefetch-url https://gms.yoyogames.com/GameMaker-Beta-2024.1400.4.1003.deb)
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    xorg.libXxf86vm
    xorg.libX11
    xorg.libXi
    xorg.libXext
    xorg.libXrandr
    xorg.libXfixes
    stdenv.cc.cc.lib # for gcc.cc.lib
    openal
    libGL
    libGLU
    fuse
    curl
    freetype
    gtk3
    libpulseaudio
    zlib
    gmp
    e2fsprogs
    libgpg-error
    libpng
    brotli
    icu
    openssl
  ];

  unpackPhase = ''
    dpkg-deb -x $src .

    # Replicating the cleanup from your flake
    rm -rf opt/GameMaker-Beta/armv7l
    rm -rf opt/GameMaker-Beta/aarch64
    rm -rf usr/
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/gamemaker
    mkdir -p $out/bin
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons/hicolor/256x256/apps

    # Copy the core IDE files
    cp -r opt/GameMaker-Beta/* $out/share/gamemaker/

    # Setup Icons and Desktop Entry from your flake
    cp $out/share/gamemaker/GameMaker.png $out/share/icons/hicolor/256x256/apps/gamemaker-${version}.png

    cat <<EOF > "$out/share/applications/gamemaker-${version}.desktop"
    [Desktop Entry]
    Exec=gamemaker
    Icon=gamemaker-${version}
    Name=GameMaker Beta v${version}
    Categories=Development
    Comment=2D Game Engine IDE
    Type=Application
    StartupWMClass=GameMaker
    EOF

    # Wrap the executable: 
    # 1. Provide shared libraries to LD_LIBRARY_PATH
    # 2. Provide the massive list of CLI tools to PATH
    makeWrapper $out/share/gamemaker/GameMaker $out/bin/gamemaker \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath buildInputs}:$out/share/gamemaker" \
      --prefix PATH : "${lib.makeBinPath runtimePackages}"

    runHook postInstall
  '';

  meta = with lib; {
    description = "GameMaker Studio IDE (Beta) Native Package";
    homepage = "https://gamemaker.io/";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = "gamemaker";
  };
}
