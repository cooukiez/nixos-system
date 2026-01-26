{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;

    colors = {
      mPrimary = "#ffffff";
      mOnPrimary = "#1b1b1b";

      mSecondary = "#c6c6c6";
      mOnSecondary = "#1b1b1b";

      mTertiary = "#e2e2e2";
      mOnTertiary = "#1b1b1b";

      mError = "#ffb4ab";
      mOnError = "#690005";

      mSurface = "#131313";
      mOnSurface = "#e2e2e2";

      mSurfaceVariant = "#1f1f1f";
      mOnSurfaceVariant = "#c6c6c6";

      mOutline = "#474747";
      mShadow = "#000000";

      mHover = "#e2e2e2";
      mOnHover = "#1b1b1b";
    };

    general = {
      allowPanelsOnScreenWithoutBar = true;

      autoStartAuth = false;

      avatarImage = "/home/ceirs/.face";

      compactLockScreen = false;
      enableLockScreenCountdown = true;

      enableShadows = true;

      lockOnSuspend = true;
      lockScreenCountdownDuration = 10000;

      radiusRatio = 1;
      scaleRatio = 1;
      screenRadiusRatio = 1;
      boxRadiusRatio = 1;
      iRadiusRatio = 1;

      dimmerOpacity = 0.45;

      shadowDirection = "bottom_right";
      shadowOffsetX = 2;
      shadowOffsetY = 3;

      animationDisabled = false;
      animationSpeed = 1.5;

      showChangelogOnStartup = true;
      showHibernateOnLockScreen = true;
      showSessionButtonsOnLockScreen = true;
      showScreenCorners = false;

      telemetryEnabled = false;
    };

    bar = {
      backgroundOpacity = 0.6;
      capsuleOpacity = 0.3;

      barType = "floating";
      density = "default";
      outerCorners = true;
      position = "top";
      exclusive = true;
      floating = true;
      hideOnOverview = false;

      frameRadius = 12;
      frameThickness = 8;

      marginHorizontal = 4;
      marginVertical = 4;

      showCapsule = false;
      showOutline = false;

      useSeparateOpacity = true;

      widgets = {
        left = [
          {
            id = "Launcher";
            icon = "rocket";
            usePrimaryColor = false;
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
            followFocusedScreen = false;
            hideUnoccupied = false;

            showApplications = false;
            showBadge = true;
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
    };

    appLauncher = {
      position = "center";
      sortByMostUsed = true;
      viewMode = "grid";
      customLaunchPrefix = "";
      customLaunchPrefixEnabled = false;
      ignoreMouseInput = false;

      autoPasteClipboard = false;
      clipboardWrapText = true;
      enableClipPreview = true;
      enableClipboardHistory = true;

      enableSettingsSearch = true;

      pinnedApps = [
        "firefox"
        "code"
        "org.gnome.Nautilus"
        "spotify"
      ];

      terminalCommand = "kitty -e";
      screenshotAnnotationTool = "";

      showCategories = true;
      showIconBackground = false;

      useApp2Unit = false;
    };

    audio = {
      cavaFrameRate = 30;
      mprisBlacklist = [ ];
      preferredPlayer = "";
      visualizerType = "linear";
      volumeFeedback = false;
      # change this if audio too low
      volumeOverdrive = false;
      volumeStep = 5;
    };

    brightness = {
      brightnessStep = 5;
      enableDdcSupport = true;
      enforceMinimum = false;
    };
  };
}
