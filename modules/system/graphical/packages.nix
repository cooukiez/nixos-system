/*
  modules/system/graphical/packages.nix

  created by ludw
  on 2026-04-22
*/

{
  pkgs,
  hostConfig,
  ...
}:
{
  #
  # packages
  #
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
    libsForQt5.qt5.qtmultimedia
    qt6.qtbase
    qt6.qtmultimedia
  ];

  compatibility = with pkgs; [
    bottles
    protonup-ng
    winetricks
    wineWow64Packages.waylandFull
  ];

  #
  # programs
  #
  development = with pkgs; [
    dbeaver-bin
    gephi
    github-desktop
    hexedit
    jflap
    renderdoc
    sql-studio

    # jetbrains
    # unstable.jetbrains-toolbox
    # unstable.jetbrains.clion
    unstable.jetbrains.idea-oss
    # unstable.jetbrains.jdk
    unstable.jetbrains.pycharm-oss
    # unstable.jetbrains.rider
    # unstable.jetbrains.rust-rover
    # unstable.jetbrains.webstorm
    # unstable.jetbrains.datagrip
  ];

  developmentGameEngines = with pkgs; [
    godot
    unityhub
  ];

  gameClients = with pkgs; [
    heroic
    badlion-client
    lunar-client

    (prismlauncher.override {
      additionalPrograms = [ ffmpeg ];

      jdks = [
        pkgs.jdk
        pkgs.jdk8
      ];
    })
  ];

  gamingExtra = with pkgs; [
    gamemode
    mangohud
    wl-crosshair
  ];

  games = with pkgs; [
    cataclysm-dda
    domination
    dwarf-fortress
    extremetuxracer
    flare
    freedroidrpg
    naev
    openclonk
    pong3d
    veloren
  ];

  modelling = with pkgs; [
    bambu-studio
    blender
    design
    dune3d
    f3d
    freecad
    librecad
    openscad
    orca-slicer
    solvespace
  ];

  other = with pkgs; [
    ausweisapp
    ausweiskopie
    bitwarden-desktop
    bitwarden-cli
    chemtool
    figma-linux
    googleearth-pro
    geogebra6
    homebank
    mangl
    meld
    minder
    rustdesk
    vym
    zoom-us

    # useless
    honklet
  ];

  pwa = with pkgs; [
    gemini-pwa
    typst-pwa
  ];

  system = with pkgs; [
    cpu-x
    displaycal
    filezilla
    fontforge-gtk
    fsv
    gparted
    hardinfo2
    ipscan
    metadata-cleaner
    pavucontrol
    qdirstat
    sniffnet
    timeshift

    # benchmark
    furmark
    geekbench
  ];
}
