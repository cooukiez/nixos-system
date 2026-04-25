/*
  modules/home/desktop/nn/noctalia/session-menu.nix

  created by ludw
  on 2026-02-26
*/

{
  pkgConfig,
  lib,
  ...
}:
let
  lock = "noctalia-shell ipc call sessionMenu toggle && ${lib.getExe pkgConfig.hyprlock}";

  powerOptions =
    lib.imap1
      (
        i: opt:
        {
          enabled = true;
          keybind = toString i;
          countdownEnabled = opt.countdown or true;
        }
        // opt
      )
      [
        {
          action = "lock";
          command = lock;
          countdown = false;
        }
        {
          action = "suspend";
          command = "${lock}; sleep 3; systemctl suspend";
        }
        {
          action = "hibernate";
          command = "${lock}; sleep 3; systemctl hibernate";
        }
        {
          action = "reboot";
          command = "systemctl reboot";
        }
        {
          action = "logout";
          command = "";
        }
        {
          action = "shutdown";
          command = "systemctl poweroff";
        }
      ];
in
{
  inherit powerOptions;

  enableCountdown = true;
  countdownDuration = 3000;

  position = "center";
  showHeader = true;
  showKeybinds = true;

  largeButtonsStyle = true;
  largeButtonsLayout = "grid";
}
