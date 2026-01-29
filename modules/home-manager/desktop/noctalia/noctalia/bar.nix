/*
  modules/home-manager/desktop/noctalia/noctalia/bar.nix

  created by ludw
  on 2026-01-27
*/

{
  barType = "floating";
  floating = true;
  density = "default";
  position = "top";

  useSeparateOpacity = true;
  backgroundOpacity = 0.6;
  capsuleOpacity = 0.3;

  showCapsule = false;
  showOutline = false;

  frameRadius = 12;
  frameThickness = 8;

  marginHorizontal = 4;
  marginVertical = 4;

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

        diskPath = "/";

        showCpuTemp = true;
        showCpuUsage = true;
        showDiskUsage = false;
        showGpuTemp = false;
        showLoadAverage = false;
        showMemoryAsPercent = false;
        showMemoryUsage = true;
        showNetworkStats = false;
        showSwapUsage = false;

        useMonospaceFont = true;
      }
      {
        id = "ActiveWindow";
        useFixedWidth = false;
        maxWidth = 145;

        scrollingMode = "hover";
        hideMode = "hidden";
        showIcon = true;
      }
      {
        id = "MediaMini";
        useFixedWidth = false;
        maxWidth = 145;

        scrollingMode = "hover";
        hideMode = "hidden";
        hideWhenIdle = false;

        compactMode = false;
        compactShowAlbumArt = true;
        compactShowVisualizer = false;

        panelShowAlbumArt = true;
        panelShowVisualizer = true;

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

        enableScrollWheel = true;
        showApplications = false;

        followFocusedScreen = false;
        showBadge = true;

        hideUnoccupied = false;
        showLabelsOnlyWhenOccupied = true;

        characterCount = 2;
        iconScale = 0.8;

        groupedBorderOpacity = 1;
        unfocusedIconsOpacity = 1;
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
        deviceNativePath = "";
        displayMode = "onhover";

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
        customIconPath = "";
        useDistroLogo = false;
      }
    ];
  };
}
