{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "appmenu-gtk-module";
  version = "24.02";

  src = pkgs.fetchGit {
    url = "https://gitlab.com/vala-panel-project/vala-panel-appmenu.git";
    rev = "master";
    sha256 = pkgs.lib.fakeSha256;
  };

  nativeBuildInputs = [
    pkgs.meson
    pkgs.gtk3
    pkgs.gtk2
    pkgs.git
  ];

  buildInputs = [];

  buildPhase = ''
    mkdir -p build
    meson build $src/subprojects/appmenu-gtk-module --prefix=$out --libexecdir=lib
    meson compile -C build
  '';

  installPhase = ''
    meson install -C build --no-rebuild
    install -Dm755 $src/80-appmenu-gtk-module.sh $out/etc/X11/xinit/xinitrc.d/
  '';

  meta = with pkgs.lib; {
    description = "Gtk module for exporting menus";
    homepage = "https://gitlab.com/vala-panel-project/vala-panel-appmenu";
    license = licenses.lgpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ pkgs.maintainers.rilianla ];
  };
}
