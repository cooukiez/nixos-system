/*
  modules/nixos/common/default.nix

  created by ludw
  on 2026-02-16
*/

{
  pkgs,
  ...
}:
{
  imports = [
    ./display.nix
    ./hardware.nix
    ./libs.nix
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
    # set LIBVA_DRIVER_NAME environment variable for video acceleration
    LIBVA_DRIVER_NAME = "iHD";

    # fix for nautilus extension path
    NAUTILUS_EXTENSION_DIR = "${pkgs.nautilus-python}/lib/nautilus/extensions";
    NAUTILUS_4_EXTENSION_DIR = "${pkgs.nautilus-python}/lib/nautilus/extensions-4";

    VCPKG_FORCE_SYSTEM_BINARIES = 1;
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
    cmus
    cointop
    coreutils
    cowsay
    cpuid
    ctop
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
    exfatprogs
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
    just
    kdash
    khal
    killall
    lazydocker
    lazygit
    lolcat
    mangl
    mani
    manix
    mariadb
    mesa
    most
    mtools
    mutt
    navi
    neofetch
    newsboat
    ngrok
    ntfsprogs
    parted
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
    taskwarrior2
    tealdeer
    tldr
    tlrc
    tmate
    toybox
    transfer-sh
    tre
    tree
    tuir
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
    xsel
    yazi
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

    # nixos related
    home-manager
    nixfmt-rfc-style
    nixfmt-tree
    nix-prefetch-git
    nix-search
  ];
}
