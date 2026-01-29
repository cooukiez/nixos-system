/*
  modules/nixos/common/display.nix

  created by ludw
  on 2026-01-01
*/

{
  pkgs,
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

  # xdg desktop portal
  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
    icons.enable = true;
  };

  # fonts configuration
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    roboto
    inter
  ];
}
