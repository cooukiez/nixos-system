/*
  modules/nixos/programs/default.nix

  created by ludw
  on 2026-02-21
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

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/etc/nixos"; # sets NH_OS_FLAKE variable for you
  };

  # SUID wrappers
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # enable flatpak and install apps from flathub
  services.flatpak = {
    enable = true;

    # declare packages declaratively
    packages = [
      # "be.alexandervanhee.gradia"
      # "com.github.vikdevelop.photopea_app"
      # "com.leinardi.gst"
      # "com.odnoyko.valot"
      # "org.freedownloadmanager.Manager"

      "edu.mit.Scratch"
      "io.github.giantpinkrobots.flatsweep"
      "org.jdownloader.JDownloader"
      "org.turbowarp.TurboWarp"
      "org.vinegarhq.Sober"
      "org.vinegarhq.Vinegar"
      "page.codeberg.lo_vely.Nucleus"
      "tech.digiroad.Convertidor"
    ];

    update.onActivation = true;

    # see https://github.com/gmodena/nix-flatpak?tab=readme-ov-file#overrides
    overrides = {
      global = {
        # force Wayland by default
        Context.sockets = [
          "wayland"
          # "!x11"
          # "!fallback-x11"
        ];
        Environment = {
          # fix un-themed cursor in some wayland apps
          XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
          # force correct theme for some gtk appsjoplin-desktop
          GTK_THEME = "Adwaita:dark";
        };
      };
    };
  };

  services.snap.enable = true;

  # running gnome apps outside of gnome
  programs.dconf.enable = true;
  services.gvfs.enable = true;

  # gnome calendar support
  services.gnome.evolution-data-server.enable = true;
  services.gnome.tinysparql.enable = true;
  services.gnome.localsearch.enable = true;

  environment.systemPackages = with pkgs; [
    # general programs, sorted alphabetically
    affine
    ausweisapp
    ausweiskopie
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
    figma-linux
    firestarter
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
    homebank
    icon-slicer
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
    obsidian
    onlyoffice-desktopeditors
    openscad
    openseeface
    orca-slicer
    pavucontrol
    qdirstat
    renderdoc
    rustdesk
    safeeyes
    scribus
    shutter
    slack
    sniffnet
    solvespace
    sql-studio
    timeshift
    wl-crosshair
    zed-editor
    zoom-us
    zotero

    # code editors / IDE
    inputs.gamemaker.packages.${hostSystem}.ide-latest-beta
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

    # from flakes
    inputs.honklet.packages.${hostSystem}.default
  ];
}
