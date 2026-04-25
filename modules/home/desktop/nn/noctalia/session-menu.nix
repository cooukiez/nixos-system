/*
  modules/home/desktop/nn/noctalia/session-menu.nix

  created by ludw
  on 2026-02-26
*/

{
  pkgs,
  lib,
  ...
}:
let
  lock = "noctalia-shell ipc call sessionMenu toggle && ${lib.getExe pkgs.hyprlock}";
  sysCall = cmd: "sleep 3; systemctl ${cmd}";
  sysCallInstant = cmd: "systemctl ${cmd}";

  menuItems = [
    [
      "lock"
      lock
      false
    ]
    [
      "suspend"
      "${lock}; ${sysCall "suspend"}"
    ]
    [
      "hibernate"
      "${lock}; ${sysCall "hibernate"}"
    ]
    [
      "reboot"
      (sysCallInstant "reboot")
    ]
    [
      "logout"
      ""
    ]
    [
      "shutdown"
      (sysCallInstant "poweroff")
    ]
  ];
in
{
  enableCountdown = true;
  countdownDuration = 3000;

  position = "center";

  showHeader = true;
  showKeybinds = true;

  largeButtonsStyle = true;
  largeButtonsLayout = "grid";

  powerOptions =
    (lib.imap1 (i: opt: {
      action = builtins.elemAt opt 0;
      command = builtins.elemAt opt 1;
      keybind = toString i;

      countdownEnabled = lib.attrByPath [ 2 ] true opt;
      enabled = true;
    }) menuItems)
    ++ [
      {
        action = "rebootToUefi";
        enabled = false;
      }
      {
        action = "userspaceReboot";
        enabled = false;
      }
    ];
}
