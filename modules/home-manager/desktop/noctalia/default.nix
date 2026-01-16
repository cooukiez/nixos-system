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

    inputs.noctalia.homeModules.default
  ];

  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":";
    };
  };

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
  };
}
