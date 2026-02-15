{
  pkgs,
  ...
}:
{
  # java support
  programs.java.enable = true;

  environment.systemPackages = with pkgs; [
    # general libraries, sorted alphabetically
    fuse3
    ifuse
    libimobiledevice
    libimobiledevice-glue
    libgphoto2
    gvfs
    libnotify
    tesseract
    vulkan-tools

    # gtk / qt
    libappindicator
    libappindicator-gtk2
    libappindicator-gtk3
    libsForQt5.qt5.qtbase
    libsForQt5.qt5.qtdeclarative
    libsForQt5.qt5.qtmultimedia
    qt6.qtbase
    qt6.qtmultimedia
    qt6.qtsvg
    qt6.qtvirtualkeyboard

    # input libraries
    libinput
    libinput-gestures
    libxcb-cursor
    libxcursor

    # appmenu support
    appmenu-glib-translator
    haskellPackages.gi-dbusmenu # not needed
    haskellPackages.gi-dbusmenugtk3 # not needed
    libdbusmenu
    libdbusmenu-gtk2
    libdbusmenu-gtk3
    lxqt.libdbusmenu-lxqt

    # dotnet
    dotnetCorePackages.sdk_9_0-bin

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
