{
  inputs,
  config,
  pkgs,
  lib,
}:
(import ./wrappers/hypridle.nix { inherit config wlib lib; }).apply {
  inherit pkgs;

  settings = {
    general = {
      ignore_dbus_inhibit = false;
      lock_cmd = "hyprlock";
    };

    listener = [
      # lock after 10 min
      {
        timeout = 10 * 60;
        on-timeout = "hyprlock";
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
