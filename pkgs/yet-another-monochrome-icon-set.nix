{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "yamis";
  version = "1.2";

  src = pkgs.fetchFromBitbucket {
    owner = "dirn-typo";
    repo = "yet-another-monochrome-icon-set";
    rev = "default";
    sha256 = "sha256-<computed-sha256>";
  };

  nativeBuildInputs = [
    pkgs.makeWrapper
  ];

  installPhase = ''
    mkdir -p $out/share/icons/${pname}
    cp -r * $out/share/icons/${pname}
  '';

  meta = with pkgs.lib; {
    description = "Yet Another Monochrome Icon Set (YAMIS)";
    homepage = "https://bitbucket.org/dirn-typo/yet-another-monochrome-icon-set";
    license = licenses.mit;
  };
}
