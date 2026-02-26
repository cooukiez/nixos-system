/*
  modules/nixos/common/libs.nix

  created by ludw
  on 2026-02-23
*/

{
  pkgs,
  ...
}:
{
  # java support
  programs.java.enable = true;

  environment.systemPackages = with pkgs; [
    # general tools / libraries, sorted alphabetically
    bluez-tools
    ffmpeg
    fuse3
    go
    icu
    ifuse
    imagemagick
    intel-gpu-tools
    libgphoto2
    libimobiledevice
    libimobiledevice-glue
    libnotify
    mariadb
    nvtopPackages.full
    pandoc
    shared-mime-info
    tesseract
    vulkan-tools
    yt-dlp
    zlib

    # widgets / input
    libsForQt5.qt5.qtbase
    libsForQt5.qt5.qtdeclarative
    libsForQt5.qt5.qtmultimedia
    qt6.qtbase
    qt6.qtmultimedia
    qt6.qtsvg
    qt6.qtvirtualkeyboard
    libinput
    libinput-gestures
    libxcb-cursor
    libxcursor

    # appmenu support
    libappindicator
    libappindicator-gtk2
    libappindicator-gtk3
    appmenu-glib-translator
    haskellPackages.gi-dbusmenu # not needed
    haskellPackages.gi-dbusmenugtk3 # not needed
    libdbusmenu
    libdbusmenu-gtk2
    libdbusmenu-gtk3
    lxqt.libdbusmenu-lxqt

    #
    # development libraries
    #

    # dotnet
    (dotnetCorePackages.combinePackages [
      dotnetCorePackages.sdk_8_0-bin
      dotnetCorePackages.sdk_9_0-bin
      dotnetCorePackages.sdk_10_0-bin
    ])

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

    #
    # compatibility layers
    #

    # wine compatibilty
    wineWowPackages.stable
    winetricks
    wineWowPackages.waylandFull

    # proton
    protonup-ng
  ];

  environment.shellAliases = {
    # dotnet version aliases
    dotnet8 = "${pkgs.dotnetCorePackages.sdk_8_0-bin}/bin/dotnet";
    dotnet9 = "${pkgs.dotnetCorePackages.sdk_9_0-bin}/bin/dotnet";
    dotnet10 = "${pkgs.dotnetCorePackages.sdk_10_0-bin}/bin/dotnet";
  };
}
