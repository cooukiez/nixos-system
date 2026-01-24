{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./network-services.nix
    ./penetration-testing.nix
  ];

  # SUID wrappers
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.flatpak.enable = true;
  systemd.services.flatpak-flathub = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # flatpak apps
  systemd.services.flatpak-apps = {
    wantedBy = [ "multi-user.target" ];
    after = [ "flatpak-flathub.service" ];
    requires = [ "flatpak-flathub.service" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak install -y --system flathub com.github.vikdevelop.photopea_app
      flatpak install -y --system flathub com.leinardi.gst
      flatpak install -y --system flathub be.alexandervanhee.gradia
    '';
  };

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
    strawberry
    qbittorrent-enhanced
    qbittorrent-cli
    intel-gpu-tools
    furmark
    firestarter
    geekbench
    sxiv
    # morgen
    bitwarden-desktop
    bitwarden-cli
    jetbrains.rider
    jetbrains.rust-rover
    jetbrains.webstorm
    jetbrains.pycharm
    jetbrains.phpstorm
    jetbrains.idea
    jetbrains.clion
    jetbrains-toolbox
    zathura
    zathuraPkgs.zathura_core
    zathuraPkgs.zathura_pdf_mupdf
    imv

    # from flakes
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.twilight
    inputs.honklet.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # enable programs here
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;

    languagePacks = [ "en-US" "de" ];

    nativeMessagingHosts.packages = [
      pkgs.kdePackages.plasma-browser-integration
    ];

    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };

    policies = {
      DisableTelemetry = true;
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
