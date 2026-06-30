/*
modules/home/desktop/nn/noctalia/session-menu.nix

part of nixos system
created 2026-06-16 by ludw
*/
{
  lib,
  nnSessionCommands,
  ...
}: let
  closeMenu = "noctalia-shell ipc call sessionMenu toggle";

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
      # leave session open
      {
        action = "lock";
        command = "${closeMenu} && ${nnSessionCommands.lock}";
        countdown = false;
      }
      {
        action = "suspend";
        command = "${closeMenu} && ${nnSessionCommands.suspend}";
      }
      {
        action = "hibernate";
        command = "${closeMenu} && ${nnSessionCommands.hibernate}";
      }
      # close session
      {
        action = "reboot";
        command = nnSessionCommands.reboot;
      }
      {
        action = "logout";
        command = nnSessionCommands.logout;
      }
      {
        action = "shutdown";
        command = nnSessionCommands.shutdown;
      }
    ];
in {
  inherit powerOptions;

  enableCountdown = true;
  countdownDuration = 3000;

  position = "center";
  showHeader = true;
  showKeybinds = true;

  largeButtonsStyle = true;
  largeButtonsLayout = "grid";
}
