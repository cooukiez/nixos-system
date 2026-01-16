{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "breeze-chameleon-icons";
  version = "1.0";

  src = pkgs.fetchFromGitHub {
    owner = "L4ki";
    repo = "Breeze-Chameleon-Icons";
    rev = "39ca2a55ba5289a96b2e744cd3670e020fb7e217";
    sha256 = "0k8hj8yrlg36xcq1jkalzrcrx1jhlfvli6g3ad03hgrqj4s14yy0";
  };

  nativeBuildInputs = [
    pkgs.unzip
    pkgs.makeWrapper
  ];

  installPhase = ''
    ICON_DIR=$out/share/icons

    mkdir -p "$ICON_DIR"

    # install each icon theme folder
    cp -r "$src/Breeze Chameleon Dark" "$ICON_DIR/Breeze-Chameleon-Dark"
    cp -r "$src/Breeze Chameleon Light" "$ICON_DIR/Breeze-Chameleon-Light"
    cp -r "$src/Breeze-Round-Chameleon Dark Icons" "$ICON_DIR/Breeze-Round-Chameleon-Dark"
    cp -r "$src/Breeze-Round-Chameleon Light Icons" "$ICON_DIR/Breeze-Round-Chameleon-Light"
    cp -r "$src/Chameleon-Symbolic-Dark-Icons" "$ICON_DIR/Chameleon-Symbolic-Dark"
  '';

  meta = with pkgs.lib; {
    description = "Breeze Chameleon icon themes (Dark and Light variants) for KDE";
    license = licenses.gpl3;
    homepage = "https://github.com/L4ki/Breeze-Chameleon-Icons";
  };
}
