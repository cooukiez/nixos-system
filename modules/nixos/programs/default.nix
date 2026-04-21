/*
  modules/nixos/programs/default.nix

  created by ludw
  on 2026-02-26
*/

{
  inputs,
  hostSystem,
  pkgs,
  ...
}:
{
  imports = [
    ./cli-tools.nix
    ./file-explorers.nix
    ./gaming.nix
    ./media.nix
    ./network-services.nix
    ./penetration-testing.nix
    ./services.nix
    ./web.nix
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.systemPackages = with pkgs; [
    # general programs, sorted alphabetically
    affine
    ausweisapp
    ausweiskopie
    bambu-studio
    bitwarden-desktop
    blender
    bottles
    calibre
    chemtool
    cpu-x
    dbeaver-bin
    design
    displaycal
    dune3d
    f3d
    figma-linux
    filezilla
    firestarter
    fontforge-gtk
    freecad
    fsv
    furmark
    geekbench
    geogebra6
    gephi
    github-desktop
    godot
    googleearth-pro
    gparted
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    hardcode-tray
    hardinfo2
    heidisql
    heroic
    hexedit
    homebank
    icon-slicer
    iloader
    ipscan
    jflap
    joplin-desktop
    librecad
    lutris
    mangl
    mangohud
    meld
    metadata-cleaner
    minder
    muse-sounds-manager
    musescore
    nicotine-plus
    obsidian
    onlyoffice-desktopeditors
    openscad
    openseeface
    orca-slicer
    pavucontrol
    qdirstat
    renderdoc
    rnote
    rustdesk
    scribus
    shutter
    slack
    sniffnet
    solvespace
    sql-studio
    texstudio
    timeshift
    vym
    wl-crosshair
    zed-editor
    zoom-us
    zotero

    # code editors / IDE
    inputs.gamemaker.packages.${hostSystem}.default
    unityhub
    unstable.jetbrains-toolbox
    unstable.jetbrains.clion
    unstable.jetbrains.idea-oss
    unstable.jetbrains.jdk
    unstable.jetbrains.pycharm-oss
    unstable.jetbrains.rider
    unstable.jetbrains.rust-rover
    unstable.jetbrains.webstorm
    unstable.jetbrains.datagrip

    # new
    vinegar

    # web utility
    authelia

    # from flakes
    inputs.honklet.packages.${hostSystem}.default
  ];
}
