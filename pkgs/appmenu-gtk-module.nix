{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "appmenu-gtk-module";
  version = "25.04";

  src = pkgs.fetchFromGitLab {
    owner = "vala-panel-project";
    repo = "vala-panel-appmenu";
    rev = version;
    sha256 = "sha256-843b24f98f02feb8cbfdda26630018ae95f8ac4959de9deb88cf1a13506f845f=";
  };

  nativeBuildInputs = [
    pkgs.meson
    pkgs.ninja
    pkgs.pkg-config
  ];

  buildInputs = [
    pkgs.gtk3
    pkgs.glib
    pkgs.gdk-pixbuf
  ];

  mesonFlags = [
    "-Dgtk=3"
  ];

  configurePhase = ''
    meson setup build subprojects/appmenu-gtk-module \
      --prefix=$out \
      -Dgtk=3
  '';

  buildPhase = ''
    ninja -C build
  '';

  installPhase = ''
    ninja -C build install

    mkdir -p $out/etc/X11/xinit/xinitrc.d
    cp ${./80-appmenu-gtk-module.sh} \
      $out/etc/X11/xinit/xinitrc.d/80-appmenu-gtk-module.sh
  '';

  meta = with pkgs.lib; {
    description = "application menu gtk module";
    homepage = "https://gitlab.com/vala-panel-project/vala-panel-appmenu/";
    license = licenses.lgpl3Only;
    platforms = platforms.linux;
  };
}
