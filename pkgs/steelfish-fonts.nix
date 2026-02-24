{
  lib,
  stdenvNoCC,
  fetchurl,
  unzip,
}:

stdenvNoCC.mkDerivation rec {
  pname = "steelfish-fonts";
  version = "2026";

  src = fetchurl {
    url = "https://www.1001fonts.com/download/steelfish.zip";
    hash = "sha256-R/8yEa8vVsh8YtH9vI+02M1y2O3jBqHq1A1E1G5D8vE=";
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
