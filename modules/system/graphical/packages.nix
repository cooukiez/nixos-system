/*
modules/system/graphical/packages.nix

part of nixos system
created 2026-04-22 by ludw
*/
{pkgs, ...}: {
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
    github-desktop
    hexedit
    jflap
    renderdoc
    sql-studio

    (symlinkJoin {
      name = "gephi-wayland";
      paths = [gephi];

      nativeBuildInputs = [makeWrapper copyDesktopItems];

      postBuild = ''
        wrapProgram $out/bin/gephi \
          --set _JAVA_AWT_WM_NONREPARENTING 1
      '';

      desktopItems = [
        (makeDesktopItem {
          name = "gephi";
          exec = "gephi";
          icon = "gephi";
          comment = "Graph Visualization and Manipulation Platform";
          desktopName = "Gephi Graph Platform";
          genericName = "Graph Analysis Tool";
          categories = ["Development" "Science" "DataVisualization"];
          terminal = false;
        })
      ];
    })

    # jetbrains
    unstable.jetbrains.idea-oss
    unstable.jetbrains.pycharm-oss
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
      additionalPrograms = [ffmpeg];

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
    armagetronad
    assaultcube
    bzflag
    cataclysm-dda
    domination
    doomretro
    dwarf-fortress-full
    ecwolf
    endless-sky
    ete
    extremetuxracer
    flare
    freeciv
    freedink
    freedroidrpg
    gnubg
    lincity
    lincity-ng
    luanti
    lutris
    mindustry
    nethack
    nexuiz
    openarena
    openclonk
    openloco
    openra
    openttd
    pong3d
    quakespasm
    sgt-puzzles
    shattered-pixel-dungeon
    space-cadet-pinball
    uhexen2
    veloren
    vkquake
    wesnoth
    xonotic
    zeroad-unwrapped
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
    whatsapp-pwa
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
