/*
  modules/home/desktop/nn/noctalia/plugin-settings.nix

  created by ludw
  on 2026-02-26
*/

{
  catwalk = {
    minimumThreshold = 20;
    hideBackground = false;
  };

  network-indicator = {
    useCustomColors = false;
    showNumbers = true;

    forceMegabytes = true;
    byteThresholdActive = 1024;

    arrowType = "caret";
    minWidth = 70;

    fontSizeModifier = 1;
    iconSizeModifier = 1;
    spacingInbetween = -1;
  };

  network-manager-vpn = {
    displayMode = "alwaysHide";
    connectedColor = "";
    disconnectedColor = "";
  };

  privacy-indicator = {
    hideInactive = false;
    enableToast = true;
    removeMargins = false;

    iconSpacing = 4;

    activeColor = "primary";
    inactiveColor = "none";

    micFilterRegex = "";
    camFilterRegex = "pipewire|wireplumber";
  };

  screenshot = {
    mode = "screen";
  };

  tailscale = {
    compactMode = true;
    showIpAddress = false;
    showPeerCount = false;

    hideDisconnected = false;
    hideMullvadExitNodes = true;

    terminalCommand = "kitty";

    pingCount = 5;

    refreshInterval = 30000;

    defaultPeerAction = "copy-ip";
  };

  timer = {
    compactMode = false;
  };

  # not used currently
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
