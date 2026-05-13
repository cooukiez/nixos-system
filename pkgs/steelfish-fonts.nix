/*
  pkgs/steelfish-fonts.nix

  part of nixos system
  created 2026-02-26
*/

{
  stdenvNoCC,
  lib,
  fetchurl,
  unzip,
}:
stdenvNoCC.mkDerivation {
  pname = "steelfish-fonts";
  version = "0-unstable-2026-05-05";

  src = fetchurl {
    url = "https://www.1001fonts.com/download/steelfish.zip";
    hash = "sha256-R3B92Y60phVPNtVZy843wMe2jjaVXwzipBDYsyrSefQ=";
  };

  nativeBuildInputs = [ unzip ];

  unpackPhase = ''
    unzip $src
  '';

  installPhase = ''
    runHook preInstall

    install -dm755 $out/share/fonts/opentype

    find . -name "*.otf" -exec install -m444 {} $out/share/fonts/opentype/ \;

    runHook postInstall
  '';

  meta = with lib; {
    description = "Steelfish font family by Larabie Fonts";
    homepage = "https://www.1001fonts.com/steelfish-font.html";
    license = licenses.free;
    platforms = platforms.all;
  };
}
