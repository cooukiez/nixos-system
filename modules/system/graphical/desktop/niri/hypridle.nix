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
      # lock after 10 min
      {
        timeout = 10 * 60;
        on-timeout = "${lib.getExe config.pkgConfig.hyprlock}";
      }

      # turn off screen after 5 min
      {
        timeout = 5 * 60;
        on-timeout = "niri msg action power-off-monitors";
        on-resume = "niri msg action power-on-monitors";
      }
    ];
  };
}
