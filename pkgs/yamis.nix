# disabled
{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "yet-another-monochrome-icon-set";
  version = "1.2.3";

  src = pkgs.fetchgit {
    url = "https://bitbucket.org/dirn-typo/yet-another-monochrome-icon-set.git";
    rev = "4e3cb9ded2a0bb39d563996a81bcbded926e5515";
    sha256 = "sha256-0a0zi288nfr7ri2lwbzgq29k6q3hwcf112x5d076sn2y5indbln7";
  };

  nativeBuildInputs = [
    pkgs.makeWrapper
  ];

  installPhase = ''
    mkdir -p $out/share/icons/${pname}
    cp -r * $out/share/icons/${pname}
    ln -s $out/share/icons/${pname} /run/current-system/sw/share/icons/${pname}
  '';

  meta = with pkgs.lib; {
    description = "Yet Another Monochrome Icon Set (YAMIS)";
    homepage = "https://bitbucket.org/dirn-typo/yet-another-monochrome-icon-set";
    license = licenses.gpl3Plus;
  };
}
