/*
  modules/home/desktop/nn/noctalia/bar.nix

  created by ludw
  on 2026-02-26
*/

{
  # layout
  position = "top";
  barType = "floating";
  density = "default";
  marginHorizontal = 4;
  marginVertical = 4;
  contentPadding = 4;
  widgetSpacing = 6;
  enableExclusionZoneInset = true;

  # behavior
  displayMode = "always_visible";
  autoHideDelay = 500;
  autoShowDelay = 150;
  showOnWorkspaceSwitch = true;
  hideOnOverview = false;

  # visuals
  backgroundOpacity = 0.75;
  useSeparateOpacity = true;
  frameRadius = 12;
  frameThickness = 8;
  outerCorners = true;
  showOutline = false;
  fontScale = 1;

  showCapsule = false;
  capsuleColorKey = "none";
  capsuleOpacity = 0.3;

  # interaction
  middleClickAction = "launcherPanel";
  middleClickCommand = "";
  middleClickFollowMouse = false;

  rightClickAction = "controlCenter";
  rightClickCommand = "";
  rightClickFollowMouse = false;

  mouseWheelAction = "workspace";
  mouseWheelWrap = true;
  reverseScroll = false;

  # monitors
  monitors = [ ];
  screenOverrides = [
    {
      enabled = false;
      name = "eDP-1";
    }
  ];

  widgets = {
    left = [
      {
        id = "Launcher";
        icon = "rocket";
      }
      {
        id = "Clock";
        formatHorizontal = "HH:mm ddd, MMM dd";
        formatVertical = "HH mm - dd MM";
        tooltipFormat = "HH:mm ddd, MMM dd";
      }
      {
        id = "SystemMonitor";
        compactMode = true;

        iconColor = "none";
        textColor = "none";
        useMonospaceFont = true;
        usePadding = false;

        diskPath = "/";

        showCpuCores = false;
        showCpuFreq = false;
        showCpuTemp = true;
        showCpuUsage = true;
        showDiskAvailable = false;
        showDiskUsage = true;
        showDiskUsageAsPercent = false;
        showGpuTemp = false;
        showLoadAverage = false;
        showMemoryAsPercent = false;
        showMemoryUsage = true;
        showNetworkStats = false;
        showSwapUsage = false;
      }
      {
        id = "ActiveWindow";
        useFixedWidth = false;
        maxWidth = 145;

        colorizeIcons = false;
        textColor = "none";

        showIcon = true;
        showText = true;

        hideMode = "hidden";
        scrollingMode = "hover";
      }
      {
        id = "MediaMini";
        useFixedWidth = false;
        maxWidth = 145;

        compactMode = false;
        compactShowAlbumArt = true;
        compactShowVisualizer = false;
        hideMode = "hidden";
        hideWhenIdle = false;

        panelShowAlbumArt = true;
        panelShowVisualizer = true;
        scrollingMode = "hover";

        showAlbumArt = true;
        showArtistFirst = true;
        showProgressRing = true;
        showVisualizer = false;

        visualizerType = "linear";
      }
    ];

    center = [
      {
        id = "Workspace";
        labelMode = "index";

        iconScale = 0.8;
        fontWeight = "bold";
        characterCount = 2;
        showBadge = true;

        enableScrollWheel = true;
        followFocusedScreen = false;
        hideUnoccupied = false;

        showApplications = true;
        showApplicationsHover = false;
        showLabelsOnlyWhenOccupied = true;

        colorizeIcons = false;

        emptyColor = "secondary";
        focusedColor = "primary";
        occupiedColor = "secondary";

        unfocusedIconsOpacity = 1;
        groupedBorderOpacity = 1;
        pillSize = 0.6;
      }
    ];

    right = [
      {
        id = "plugin:catwalk";
        defaultSettings = {
          hideBackground = false;
          minimumThreshold = 10;
        };
      }
      {
        id = "plugin:privacy-indicator";
        defaultSettings = {
          hideInactive = false;
          removeMargins = false;
        };
      }
      {
        id = "plugin:tailscale";
      }
      {
        id = "plugin:timer";
        defaultSettings = {
          compactMode = false;
          defaultDuration = 0;
        };
      }
      {
        id = "Tray";
        drawerEnabled = true;
        hidePassive = false;
      }
      {
        id = "NotificationHistory";
        hideWhenZero = false;
        hideWhenZeroUnread = false;
        showUnreadBadge = true;
      }
      {
        id = "Battery";
        deviceNativePath = "BAT0";
        displayMode = "graphic";

        hideIfIdle = false;
        hideIfNotDetected = false;

        showNoctaliaPerformance = true;
        showPowerProfiles = true;
        warningThreshold = 20;
      }
      {
        id = "Volume";
        displayMode = "onhover";
        middleClickCommand = "pwvucontrol || pavucontrol";
      }
      {
        id = "Brightness";
        displayMode = "onhover";
      }
      {
        id = "ControlCenter";
        icon = "noctalia";
        enableColorization = false;
        colorizeSystemIcon = "none";
        useDistroLogo = false;
        customIconPath = "";
      }
    ];
  };
}
