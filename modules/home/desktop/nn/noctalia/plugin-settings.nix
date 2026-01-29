/*
  modules/home-manager/desktop/noctalia/noctalia/plugin-settings.nix

  created by ludw
  on 2026-01-29
*/

{
  catwalk = {
    minimumThreshold = 20;
    hideBackground = false;
  };

  timer = {
    compactMode = false;
  };

  # not in use currently
  world-clock = {
    timezones = [
      {
        name = "New York";
        timezone = "America/New_York";
        enabled = true;
      }
      {
        name = "London";
        timezone = "Europe/London";
        enabled = true;
      }
      {
        name = "Tokyo";
        timezone = "Asia/Tokyo";
        enabled = true;
      }
      {
        name = "Nova York";
        timezone = "America/New_York";
        enabled = true;
      }
      {
        name = "Nova York";
        timezone = "America/New_York";
        enabled = true;
      }
    ];

    rotationInterval = 5000;
    timeFormat = "HH:mm";
  };
}
