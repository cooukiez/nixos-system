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

    # nixos related
    home-manager
    nixfmt-rfc-style
    nixfmt-tree
  ];

  # fonts configuration
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    roboto
    inter
  ];
}
