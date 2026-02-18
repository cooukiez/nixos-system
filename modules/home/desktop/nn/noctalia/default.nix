/*
  modules/home/desktop/nn/noctalia/default.nix

  created by ludw
  on 2026-02-17
*/

{
  inputs,
  config,
  userConfig,
  hostSystem,
  pkgs,
  ...
}:
{
  systemd.user.services.noctalia = {
    Unit = {
      Description = "Noctalia Shell";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.quickshell}/bin/qs -c noctalia-shell";
      # Restart = "on-failure";
      # RestartSec = 5;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # copy avatar picture
  home.file.".face".source = userConfig.avatar;

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
    package = (
      inputs.noctalia.packages.${hostSystem}.default.override {
        calendarSupport = true;
      }
    );

    plugins = import ./plugins.nix;
    pluginSettings = import ./plugin-settings.nix;

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

    settings = {
      settingsVersion = 45;

      appLauncher = import ./app-launcher.nix;
      bar = import ./bar.nix;
      controlCenter = import ./control-center.nix;
      desktopWidgets = import ./desktop-widgets.nix;
      sessionMenu = import ./session-menu.nix;

      # colorSchemes.predefinedScheme = "Monochrome";

      general = {
        autoStartAuth = false;
        avatarImage = "${config.home.homeDirectory}/.face";

        compactLockScreen = false;
        enableLockScreenCountdown = true;
        lockOnSuspend = true;
        lockScreenCountdownDuration = 10000;

        dimmerOpacity = 0.45;

        radiusRatio = 1;
        scaleRatio = 1;
        screenRadiusRatio = 1;
        boxRadiusRatio = 1;
        iRadiusRatio = 1;

        animationDisabled = false;
        animationSpeed = 1.5;

        showChangelogOnStartup = true;
        showHibernateOnLockScreen = true;
        showSessionButtonsOnLockScreen = true;
        showScreenCorners = false;

        telemetryEnabled = false;
      };

      plugins = {
        autoUpdate = true;
      };

      audio = {
        cavaFrameRate = 30;
        mprisBlacklist = [ ];
        preferredPlayer = "";
        visualizerType = "none";
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

      dock = {
        enabled = false;
        /*
          position = "bottom";
          displayMode = "auto_hide";
          pinnedStatic = true;
          onlySameOutput = true;
          inactiveIndicators = false;

          deadOpacity = 0.25;
          backgroundOpacity = 1;
          animationSpeed = 1;
          floatingRatio = 1;
          size = 1.2;

          pinnedApps = [
            "firefox"
            "code"
            "spotify"
            "kitty"
            "thunar"
          ];
        */
      };

      location = {
        name = "Berlin";
        weatherEnabled = true;
        weatherShowEffects = true;

        useFahrenheit = false;
        use12hourFormat = false;

        showWeekNumberInCalendar = true;
      };

      nightLight = {
        enabled = true;
        forced = false;
        autoSchedule = true;

        nightTemp = "4000";
        dayTemp = "6500";
        manualSunrise = "06:30";
        manualSunset = "18:30";
      };

      notifications = {
        enabled = true;
        location = "top_right";
        overlayLayer = true;

        respectExpireTimeout = false;
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 8;
        criticalUrgencyDuration = 15;

        enableKeyboardLayoutToast = true;
        enableMediaToast = false;

        saveToHistory = {
          low = true;
          normal = true;
          critical = true;
        };

        sounds = {
          enabled = false;
        };
      };

      osd = {
        enabled = true;
        location = "bottom_left";
        autoHideMs = 2000;
        overlayLayer = true;
        enabledTypes = [
          0
          1
          2
          3
        ];
      };

      ui = {
        settingsPanelMode = "attached";
        boxBorderEnabled = false;
        tooltipsEnabled = true;
        panelBackgroundOpacity = 1;
        panelsAttachedToBar = true;

        fontDefault = "Roboto";
        fontDefaultScale = 1;
        fontFixed = "JetBrainsMono NF";
        fontFixedScale = 1;

        networkPanelView = "wifi";
        wifiDetailsViewMode = "grid";
        bluetoothDetailsViewMode = "grid";
        bluetoothHideUnnamedDevices = false;
      };

      wallpaper = {
        enabled = true;
        showHiddenFiles = false;
        overviewEnabled = true;
        directory = "${config.home.homeDirectory}/Pictures/Wallpapers";

        setWallpaperOnAllMonitors = true;
        monitorDirectories = [ ];
        enableMultiMonitorDirectories = false;

        viewMode = "single";
        fillMode = "crop";
        fillColor = "#000000";

        useSolidColor = false;
        solidColor = "#1a1a2e";

        automationEnabled = false;
        wallpaperChangeMode = "random";
        randomIntervalSec = 300;

        transitionDuration = 1500;
        transitionType = "random";
        transitionEdgeSmoothness = 0.05;
      };

      # run commands on certain events
      hooks = {
        enabled = true;
        wallpaperChange = "";
        darkModeChange = "";
        screenLock = "";
        screenUnlock = "";
        performanceModeEnabled = "";
        performanceModeDisabled = "";
        startup = "";
        session = "";
      };

      templates = {
        enableUserTheming = false;
        activeTemplates = [ ];
      };
    };
  };
}
