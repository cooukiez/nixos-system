/*
modules/system/graphical/packages.nix

part of nixos system
created 2026-06-16 by ludw
*/
{pkgs, ...}: let
  javaWaylandFix = binName:
    with pkgs; {
      nativeBuildInputs = [makeWrapper];

      postBuild = ''
        wrapProgram $out/bin/${binName} \
          --set _JAVA_AWT_WM_NONREPARENTING 1
      '';
    };
in {
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
    qt5.qtbase
    qt5.qtmultimedia
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
    arduino
    dbeaver-bin
    github-desktop
    hexedit
    imhex
    jflap
    renderdoc
    sql-studio

    (symlinkJoin {
        name = "cytoscape-wayland";
        paths = [cytoscape];
      }
      // javaWaylandFix "cytoscape")

    (symlinkJoin {
        name = "gephi-wayland";
        paths = [gephi];
      }
      // javaWaylandFix "gephi")

    # jetbrains
    jetbrains.idea-oss
    jetbrains.pycharm-oss
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
    # domination
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
    nexuiz
    openarena
    openclonk
    openloco
    openra
    openttd
    pong3d
    quakespasm
    # sgt-puzzles
    shattered-pixel-dungeon
    space-cadet-pinball
    uhexen2
    # veloren
    # vkquake
    wesnoth
    xonotic
    zeroad-unwrapped
  ];

  modelling = with pkgs; [
    # bambu-studio
    blender
    design
    dune3d
    f3d
    freecad
    librecad
    openscad-unstable
    orca-slicer
    solvespace
  ];

  other = with pkgs; [
    ausweisapp
    ausweiskopie
    bitwarden-desktop
    bitwarden-cli
    # chemtool
    eiciel
    figma-linux
    googleearth-pro
    geogebra6
    homebank
    jquake
    lifeograph
    mangl
    meld
    minder
    rustdesk
    sirius
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

  pentesting = with pkgs; [
    autopsy
    burpsuite
    bytecode-viewer
    cherrytree
    ddrescueview
    ghidra
    gqrx
    johnny
    maltego
    volatility3
    wireshark
    zap
    zenmap
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
