/*
  modules/system/graphical/desktop/niri/hypridle.nix

  part of nixos system
  created 2026-04-24
*/

{
  inputs,
  config,
  pkgs,
  lib,
}:
(import ./wrappers/hypridle.nix { inherit inputs config lib; }).apply {
  inherit pkgs;

  settings = {
    general = {
      ignore_dbus_inhibit = false;
      lock_cmd = "${lib.getExe config.pkgConfig.hyprlock}";
    };

    listener = [
      {
        timeout = 180;
        on-timeout = "${lib.getExe config.pkgConfig.hyprlock}";
      }
      {
        timeout = 180 * 4;
        on-timeout = "systemctl suspend";
      }
    ];
  };
}
