/*
modules/system/graphical/desktop/niri/hypridle.nix

part of nixos system
created 2026-06-16 by ludw
*/
{
  inputs,
  config,
  pkgs,
  lib,
}:
(import ./wrappers/hypridle.nix {inherit inputs config lib;}).apply {
  inherit pkgs;

  settings = {
    general = {
      ignore_dbus_inhibit = false;
      lock_cmd = config.graphicalConfig.session.nnCommands.lock;
    };

    listener = [
      {
        timeout = 180;
        on-timeout = config.graphicalConfig.session.nnCommands.lock;
      }
      {
        timeout = 180 * 4;
        on-timeout = config.graphicalConfig.session.nnCommands.suspend;
      }
    ];
  };
}
