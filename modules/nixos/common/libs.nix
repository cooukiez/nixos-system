{
  pkgs,
  ...
}:
{
  # java support
  programs.java.enable = true;

  environment.systemPackages = with pkgs; [
    # libraries, sorted alphabetically
    appmenu-glib-translator
    dotnetCorePackages.sdk_9_0-bin
    haskellPackages.gi-dbusmenu
    haskellPackages.gi-dbusmenugtk3
    libappindicator
    libappindicator-gtk2
    libappindicator-gtk3
    libdbusmenu
    libdbusmenu-gtk2
    libdbusmenu-gtk3
    libinput
    libinput-gestures
    libnotify
    libsForQt5.qt5.qtbase
    libsForQt5.qt5.qtdeclarative
    libsForQt5.qt5.qtmultimedia
    libxcb-cursor
    libxcursor
    lxqt.libdbusmenu-lxqt
    qt6.qtbase
    qt6.qtmultimedia
    qt6.qtsvg
    qt6.qtvirtualkeyboard
    tesseract
    vulkan-tools

    # python
    (python3.withPackages (
      ps: with ps; [
        numpy
        pandas
      ]
    ))

    # node
    nodejs_24
    nodePackages_latest.vercel
  ];
}
