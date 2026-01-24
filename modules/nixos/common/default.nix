{ pkgs, inputs, ... }:
{
  imports = [
    ./display.nix
    ./hardware.nix
  ];

  # enable firmware update services
  services.fwupd.enable = true;

  # enable devmon for device management
  services.devmon.enable = true;

  services.dbus.enable = true;

  # common container config
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # enable zsh
  programs.zsh.enable = true;

  environment.sessionVariables = {
    # enable wayland support in chromium and electron based applications
    NIXOS_OZONE_WL = "1";
    # remove decorations for QT apps
    UBUNTU_MENUPROXY = 1;
    # set cursor size
    XCURSOR_SIZE = "24";
    # set LIBVA_DRIVER_NAME environment variable for video acceleration
    LIBVA_DRIVER_NAME = "iHD";
    # smoother scrolling for firefox
    MOZ_USE_XINPUT2 = "1";

    # add gtk modules like this
    # GTK_MODULES = "\${GTK_MODULES}:appmenu-gtk-module";
  };

  # system packages
  environment.systemPackages = with pkgs; [
    # core / cli utilities
    vim
    wget
    git
    gcc
    glib
    gnumake
    killall
    mesa
    xmodmap
    unixtools.quota
    cifs-utils
    tree
    bottom
    btop
    htop
    toybox
    ffmpeg
    tldr
    tlrc
    xdotool
    neofetch
    fastfetch
    unzip
    cmake
    stress-ng
    bench
    vnstat

    # from flakes
    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default

    # libraries
    libnotify
    libdbusmenu
    libdbusmenu-gtk2
    libdbusmenu-gtk3
    lxqt.libdbusmenu-lxqt
    appmenu-glib-translator
    haskellPackages.gi-dbusmenu
    haskellPackages.gi-dbusmenugtk3
    # appmenu-gtk-module
    libappindicator-gtk2
    libappindicator-gtk3
    libappindicator
    qt6.qtbase
    qt6.qtsvg
    qt6.qtvirtualkeyboard
    qt6.qtmultimedia
    libxcursor
    libxcb-cursor
    libinput
    libinput-gestures
    wmctrl
    libsForQt5.qt5.qtbase
    libsForQt5.qt5.qtdeclarative
    libsForQt5.qt5.qtmultimedia
    dotnetCorePackages.sdk_9_0-bin

    # wine compatibilty
    wineWowPackages.stable
    winetricks
    wineWowPackages.waylandFull

    # nixos related
    home-manager
    nixfmt-rfc-style
    nixfmt-tree
    nix-prefetch-git
    nix-search
  ];

  # fonts configuration
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    roboto
    inter
  ];
}
