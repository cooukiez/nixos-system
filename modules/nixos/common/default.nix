/*
  modules/nixos/common/default.nix

  created by ludw
  on 2026-01-29
*/

{
  pkgs,
  ...
}:
{
  imports = [
    ./display.nix
    ./hardware.nix
  ];

  services.dbus.enable = true;

  # common container config
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

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
    # nautilus extension path
    NAUTILUS_EXTENSION_DIR = "${pkgs.nautilus-python}/lib/nautilus/extensions";
    NAUTILUS_4_EXTENSION_DIR = "${pkgs.nautilus-python}/lib/nautilus/extensions-4";

    VCPKG_FORCE_SYSTEM_BINARIES = 1;

    # add gtk modules like this
    # GTK_MODULES = "\${GTK_MODULES}:appmenu-gtk-module";
  };

  environment.pathsToLink = [
    "/share/nautilus-python/extensions"
  ];

  programs.nix-ld.enable = true;
  # programs.command-not-found = true;

  # system packages
  environment.systemPackages = with pkgs; [
    # core / cli, sorted alphabetically
    aria2
    asciinema
    bandwhich
    bat
    bench
    bottom
    brightnessctl
    browsh
    btop
    buku
    cifs-utils
    clang
    cliphist
    cmake
    cmatrix
    # cmus
    # cointop
    # cope
    coreutils
    cowsay
    cpuid
    # ctop
    curl
    ddgr
    dfc
    diff-so-fancy
    diffutils
    dmidecode
    dog
    dua
    duf
    entr
    exiftool
    eza
    fastfetch
    fdupes
    fff
    ffmpeg
    figlet
    fortune
    fzf
    gcc
    gdb
    gdb-dashboard
    git
    glances
    glib
    gnumake
    gnutar
    gping
    grim
    htop
    httpie
    hyperfine
    inetutils
    jq
    # just
    # kdash
    # khal
    killall
    # lazydocker
    # lazygit
    lolcat
    # mangl
    # mani
    # manim
    # manix
    mesa
    # most
    # mutt
    # navi
    neofetch
    # newsboat
    # ngrok
    playerctl
    procs
    rclone
    rip2
    ripgrep
    rsync
    rustup
    scc
    sd
    shared-mime-info
    sl
    slurp
    speedtest-cli
    surge
    # taskwarrior2
    tealdeer
    tldr
    tlrc
    # tmate
    # toybox
    # transfer-sh
    # tre
    tree
    # tuir
    unixtools.quota
    unzip
    ventoy
    vim
    wf-recorder
    wget
    wl-clipboard
    wmctrl
    xclip
    xdotool
    xmodmap
    # xsel
    # yazi
    zip

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
    vulkan-tools

    # python
    (python3.withPackages (
      ps: with ps; [
        numpy
        pandas
      ]
    ))

    # nixos related
    home-manager
    nixfmt-rfc-style
    nixfmt-tree
    nix-prefetch-git
    nix-search
  ];
}
