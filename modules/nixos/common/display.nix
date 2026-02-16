/*
  modules/nixos/common/display.nix

  created by ludw
  on 2026-02-14
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

  # fonts configuration
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    roboto
    inter
  ];
}
