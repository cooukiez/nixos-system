/*
  modules/nixos/common/display.nix

  created by ludw
  on 2026-02-21
*/

{
  inputs,
  pkgs,
  hostSystem,
  ...
}:
{
  # xserver / x11 configuration
  services.xserver = {
    enable = true;
    xkb = {
      layout = "de";
      options = "eurosign:e,caps:escape";
      variant = "";
    };
    excludePackages = with pkgs; [ xterm ];
  };

  # wayland configuration
  programs.xwayland.enable = true;

  # system packages
  environment.systemPackages = with pkgs; [
    # wayland utilities
    wayland-utils
    wlinhibit
  ];

  # fonts configuration
  fonts.packages = with pkgs; [
    corefonts
    dejavu_fonts
    inputs.apple-fonts.packages.${hostSystem}.sf-compact
    inputs.apple-fonts.packages.${hostSystem}.sf-mono
    inputs.apple-fonts.packages.${hostSystem}.sf-pro
    inputs.apple-fonts.packages.${hostSystem}.sf-pro-nerd
    inter
    liberation_ttf
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    roboto
    steelfish-fonts
  ];
}
