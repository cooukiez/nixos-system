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
    libsForQt5.qt5.qtdeclarative
    libsForQt5.qt5.qtmultimedia
    qt6.qtbase
    qt6.qtmultimedia
    qt6.qtsvg
    qt6.qtvirtualkeyboard
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
    heidisql
    hexedit
    jflap
    renderdoc
    sql-studio
    zed-editor

    # jetbrains
    unstable.jetbrains-toolbox
    unstable.jetbrains.clion
    unstable.jetbrains.idea-oss
    unstable.jetbrains.jdk
    unstable.jetbrains.pycharm-oss
    unstable.jetbrains.rider
    unstable.jetbrains.rust-rover
    unstable.jetbrains.webstorm
    unstable.jetbrains.datagrip
  ];

  developmentGameEngines = with pkgs; [
    gamemaker
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
    mangohud
    wl-crosshair
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
    iloader
    mangl
    meld
    minder
    rustdesk
    vym
    zoom

    # useless
    honklet
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
