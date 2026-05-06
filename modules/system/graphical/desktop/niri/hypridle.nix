/*
  modules/system/graphical/desktop/niri/hypridle.nix

  created by ludw
  on 2026-04-24
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
        timeout = 60;
        on-timeout = "niri msg action power-off-monitors";
        # on-resume = "niri msg action power-on-monitors";
      }
    ];
  };
}
