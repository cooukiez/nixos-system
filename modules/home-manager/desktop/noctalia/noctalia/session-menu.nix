/*
  modules/home-manager/desktop/noctalia/noctalia/session-menu.nix

  created by ludw
  on 2026-01-27
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
      countdownEnabled = true;
      command = "";
    }
    {
      action = "suspend";
      enabled = true;
      countdownEnabled = true;
      command = "";
    }
    {
      action = "hibernate";
      enabled = true;
      countdownEnabled = true;
      command = "";
    }
    {
      action = "reboot";
      enabled = true;
      countdownEnabled = true;
      command = "";
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
      command = "";
    }
  ];
}
