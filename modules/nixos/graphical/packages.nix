{
  pkgs,
  ...
}:
{
  desktopQt = with pkgs; [
    libsForQt5.qt5.qtbase
    libsForQt5.qt5.qtdeclarative
    libsForQt5.qt5.qtmultimedia
    qt6.qtbase
    qt6.qtmultimedia
    qt6.qtsvg
    qt6.qtvirtualkeyboard
  ];

  desktopAppmenu = with pkgs; [
    libappindicator
    libappindicator-gtk2
    libappindicator-gtk3
    appmenu-glib-translator
    libdbusmenu
    libdbusmenu-gtk2
    libdbusmenu-gtk3
    lxqt.libdbusmenu-lxqt
  ];

  desktopCore = with pkgs; [
    libnotify
    libinput
    libinput-gestures
    libxcb-cursor
    libxcursor
  ];
}
