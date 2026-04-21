{
  pkgs,
  ...
}:
{
  appmenu = with pkgs; [
    appmenu-glib-translator
    libappindicator
    libappindicator-gtk2
    libappindicator-gtk3
    libdbusmenu
    libdbusmenu-gtk2
    libdbusmenu-gtk3
    lxqt.libdbusmenu-lxqt
  ];

  core = with pkgs; [
    libinput
    libinput-gestures
    libnotify
    libxcb-cursor
    libxcursor
  ];

  qt = with pkgs; [
    libsForQt5.qt5.qtbase
    libsForQt5.qt5.qtdeclarative
    libsForQt5.qt5.qtmultimedia
    qt6.qtbase
    qt6.qtmultimedia
    qt6.qtsvg
    qt6.qtvirtualkeyboard
  ];
}
