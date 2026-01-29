/*
  modules/home-manager/desktop/noctalia/noctalia/control-center.nix

  created by ludw
  on 2026-01-27
*/

{
  position = "close_to_bar_button";
  diskPath = "/";
  shortcuts = {
    left = [
      { id = "Network"; }
      { id = "Bluetooth"; }
      { id = "WallpaperSelector"; }
      { id = "NoctaliaPerformance"; }
    ];
    right = [
      { id = "Notifications"; }
      { id = "PowerProfile"; }
      { id = "KeepAwake"; }
      { id = "NightLight"; }
    ];
  };
  cards = [
    {
      id = "profile-card";
      enabled = true;
    }
    {
      id = "shortcuts-card";
      enabled = true;
    }
    {
      id = "audio-card";
      enabled = true;
    }
    {
      id = "brightness-card";
      enabled = true;
    }
    {
      id = "weather-card";
      enabled = true;
    }
    {
      id = "media-sysmon-card";
      enabled = true;
    }
  ];
}
