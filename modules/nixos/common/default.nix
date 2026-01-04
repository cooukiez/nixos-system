{ pkgs, ... }:
{
  imports = [
    ./display.nix
    ./hardware.nix
  ];

  # enable firmware update services
  services.fwupd.enable = true;

  # enable devmon for device management
  services.devmon.enable = true;

  # openssh daemon
  services.openssh.enable = true;

  # enable zsh
  programs.zsh.enable = true;

  # system packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    gcc
    glib
    gnumake
    killall
    mesa
    unixtools.quota
    tree
    bottom
    btop
    htop

    # libraries
    libnotify
    libdbusmenu
    libdbusmenu-gtk2
    libdbusmenu-gtk3
    lxqt.libdbusmenu-lxqt
    appmenu-glib-translator
    haskellPackages.gi-dbusmenu
    haskellPackages.gi-dbusmenugtk3
#     appmenu-gtk-module
    libappindicator-gtk2
    libappindicator-gtk3
    libappindicator

    # nixos related
    home-manager
    nixfmt-rfc-style
    nixfmt-tree
    nix-prefetch-git
  ];

  # fonts configuration
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    roboto
    inter
  ];
}
