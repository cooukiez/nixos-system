/*
  modules/nixos/programs/default.nix

  created by ludw
  on 2026-02-14
*/

{
  inputs,
  hostSystem,
  pkgs,
  ...
}:
{
  imports = [
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
      "com.github.vikdevelop.photopea_app"
      "com.leinardi.gst"
      # "be.alexandervanhee.gradia"
      "edu.mit.Scratch"
      "org.turbowarp.TurboWarp"
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
          # force correct theme for some gtk apps
          GTK_THEME = "Adwaita:dark";
        };
      };
    };
  };

  # running gnome apps outside of gnome
  programs.dconf.enable = true;
  services.gvfs.enable = true;

  # gnome calendar support
  services.gnome.evolution-data-server.enable = true;
  services.gnome.tinysparql.enable = true;
  services.gnome.localsearch.enable = true;

  # enable zsh as shell
  programs.zsh.enable = true;

  # nvim console editor
  programs.neovim.enable = true;

  environment.systemPackages = with pkgs; [
    # general programs, sorted alphabetically
    affine
    bitwarden-cli
    bitwarden-desktop
    blender
    bluez-tools
    bottles
    chemtool
    cpu-x
    dbeaver-bin
    design
    dune3d
    firestarter
    freecad
    furmark
    geekbench
    geogebra6
    gephi
    gimp-with-plugins
    github-desktop
    googleearth-pro
    gparted
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    gthumb
    hardcode-tray
    hardinfo2
    heidisql
    heroic
    homebank
    icon-slicer
    unstable.ipscan
    imagemagick
    inkscape
    intel-gpu-tools
    krita
    librecad
    lutris
    mangohud
    meld
    muse-sounds-manager
    musescore
    obsidian
    openscad
    openseeface
    orca-slicer
    pavucontrol
    pinta
    qdirstat
    renderdoc
    slack
    slack-cli
    solvespace
    sql-studio
    unityhub
    zoom-us

    # code editors / IDE
    unstable.jetbrains.rust-rover
    unstable.jetbrains.pycharm
    unstable.jetbrains.idea
    unstable.jetbrains.clion
    unstable.jetbrains-toolbox
    unstable.vscode
    inputs.gamemaker.packages.${hostSystem}.default

    # wine compatibilty
    wineWowPackages.stable
    winetricks
    wineWowPackages.waylandFull

    # proton
    protonup-ng

    # from flakes
    inputs.honklet.packages.${hostSystem}.default
  ];
}
