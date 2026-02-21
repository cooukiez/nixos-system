/*
  modules/home/desktop/nn/noctalia/session-menu.nix

  created by ludw
  on 2026-02-18
*/

{
  position = "center";

  enableCountdown = true;
  countdownDuration = 3000;

  showHeader = true;
  showNumberLabels = true;

  largeButtonsStyle = true;
  largeButtonsLayout = "grid";

  powerOptions = [
    {
      action = "lock";
      enabled = true;
      countdownEnabled = false;
      command = "";
    }
    {
      action = "suspend";
      enabled = true;
      countdownEnabled = true;
      command = "niri msg action power-off-monitors && noctalia-shell ipc call lockScreen lock && systemctl suspend";
    }
    {
      action = "hibernate";
      enabled = true;
      countdownEnabled = true;
      command = "niri msg action power-off-monitors && noctalia-shell ipc call lockScreen lock && systemctl hibernate";
    }
    {
      action = "reboot";
      enabled = true;
      countdownEnabled = true;
      command = "systemctl reboot";
    }
    {
      action = "logout";
      enabled = true;
      countdownEnabled = true;
      command = "";
    }
    {
      action = "shutdown";
      enabled = true;
      countdownEnabled = true;
      command = "systemctl poweroff";
    }
    {
      action = "rebootToUefi";
      command = "";
      countdownEnabled = true;
      enabled = false;
    }
  ];
}
