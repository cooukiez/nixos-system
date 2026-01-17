{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hyprland.nix
    ./packages.nix
    ./style.nix

    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
  };
}
