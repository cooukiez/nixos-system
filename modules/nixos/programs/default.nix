{ lib, pkgs, inputs, ... }:
{
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
    gimp2-with-plugins
    krita
    inkscape
    icon-slicer
    google-chrome
    bluez-tools
    tldr
    tlrc
    homebank
    sioyek

    inputs.zen-browser.packages.${pkgs.system}.twilight

    # appearance
    papirus-icon-theme
#     tela-icon-theme
#     tela-circle-icon-theme
#     tango-icon-theme
#     fluent-icon-theme
#     reversal-icon-theme
#     qogir-icon-theme
#     numix-icon-theme
#     numix-icon-theme-circle
#     numix-icon-theme-square
#     whitesur-icon-theme
#     whitesur-cursors
#     adwaita-icon-theme-legacy
#     breeze-chameleon-icons
    hardcode-tray
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
}
