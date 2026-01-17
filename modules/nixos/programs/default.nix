{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.spicetify-nix.nixosModules.default
  ];

  # SUID wrappers
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    hardinfo2
    vlc
    mpv
    pavucontrol
    gimp-with-plugins
    krita
    inkscape
    icon-slicer
    google-chrome
    bluez-tools
    homebank
    sioyek
    discord
    legcord
    hardcode-tray
    renderdoc
    github-desktop
    vscode
    spotify

    # enable zen-browser from flake
    inputs.zen-browser.packages.${pkgs.system}.twilight
  ];

  # enable programs here
  programs.firefox = {
    enable = true;
    package = pkgs.unstable.firefox;

    nativeMessagingHosts.packages = [ pkgs.kdePackages.plasma-browser-integration ];
    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
  };

  programs.thunderbird = {
    enable = true;
    package = pkgs.unstable.thunderbird;
  };

  programs.neovim.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/etc/nixos"; # sets NH_OS_FLAKE variable for you
  };

  # running gnome apps outside of gnome
  # (nautilus)
  programs.dconf.enable = true;
  services.gvfs.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
      thunar-vcs-plugin
      thunar-dropbox-plugin
      thunar-media-tags-plugin
    ];
  };

  programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in
  {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      # hidePodcasts
      shuffle
    ];

    enabledCustomApps = with spicePkgs.apps; [
      marketplace
      lyricsPlus
      newReleases
      # ncsVisualizer
    ];

    enabledSnippets = with spicePkgs.snippets; [
      rotatingCoverart
      # pointer
    ];
  };
}
