/*
  modules/home/desktop/nn/noctalia/default.nix

  created by ludw
  on 2026-02-26
*/

{
  inputs,
  config,
  pkgs,
  pkgConfig,
  lib,
  hostConfig,
  userConfig,
  ...
}:
let
  cfg = config.desktop.nn;
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  config = lib.mkIf cfg {
    systemd.user.services.noctalia = {
      Unit = {
        Description = "Noctalia Shell";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${lib.getExe pkgConfig.noctalia}";
        Restart = "on-failure";
        RestartSec = 5;
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    programs.noctalia-shell = {
      enable = true;
      package = pkgConfig.noctalia;

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
        dock = import ./dock.nix;
        sessionMenu = import ./session-menu.nix { inherit pkgConfig lib; };

        # colorSchemes.predefinedScheme = "Monochrome";

        general = {
          # visuals
          dimmerOpacity = 0.45;
          animationSpeed = 1.5;
          animationDisabled = false;
          enableShadows = true;
          enableBlurBehind = true;
          shadowDirection = "bottom_right";
          shadowOffsetX = 2;
          shadowOffsetY = 3;

          # layout
          scaleRatio = 1;
          radiusRatio = 1;
          iRadiusRatio = 1;
          boxRadiusRatio = 1;
          screenRadiusRatio = 1;
          showScreenCorners = false;
          forceBlackScreenCorners = false;

          # clock
          clockStyle = "custom";
          clockFormat = "hh\\nmm";

          # input
          reverseScroll = false;
          smoothScrollEnabled = true;
          keybinds = {
            keyUp = [ "Up" ];
            keyDown = [ "Down" ];
            keyLeft = [ "Left" ];
            keyRight = [ "Right" ];
            keyEnter = [
              "Return"
              "Enter"
            ];
            keyEscape = [ "Esc" ];
            keyRemove = [ "Del" ];
          };

          # system
          language = "";
          avatarImage = "${config.home.homeDirectory}/.face";
          allowPanelsOnScreenWithoutBar = true;
          showChangelogOnStartup = true;
          telemetryEnabled = false;
        };

        audio = {
          volumeStep = 5;
          volumeOverdrive = false;
          volumeFeedback = false;
          volumeFeedbackSoundFile = "";

          visualizerType = "none";
          spectrumFrameRate = 30;
          spectrumMirrored = true;

          preferredPlayer = "";
          mprisBlacklist = [ ];
        };

        brightness = {
          brightnessStep = 5;
          enforceMinimum = false;
          enableDdcSupport = true;
          backlightDeviceMappings = [ ];
        };

        colorSchemes = {
          predefinedScheme = "Noctalia (default)";
          darkMode = true;

          generationMethod = "tonal-spot";
          useWallpaperColors = false;
          monitorForColors = "";

          schedulingMode = "off";
          manualSunrise = "06:30";
          manualSunset = "18:30";

          syncGsettings = true;
        };

        templates = {
          activeTemplates = [ ];
          enableUserTheming = false;
        };

        systemMonitor = {
          cpuWarningThreshold = 80;
          cpuCriticalThreshold = 90;

          gpuWarningThreshold = 80;
          gpuCriticalThreshold = 90;
          enableDgpuMonitoring = false;

          tempWarningThreshold = 80;
          tempCriticalThreshold = 90;

          memWarningThreshold = 80;
          memCriticalThreshold = 90;

          swapWarningThreshold = 80;
          swapCriticalThreshold = 90;

          diskWarningThreshold = 80;
          diskCriticalThreshold = 90;
          diskAvailWarningThreshold = 20;
          diskAvailCriticalThreshold = 10;

          batteryWarningThreshold = 20;
          batteryCriticalThreshold = 5;

          useCustomColors = false;
          warningColor = "";
          criticalColor = "";

          externalMonitor = "missioncenter";
        };

        noctaliaPerformance = {
          disableWallpaper = true;
          disableDesktopWidgets = false;
        };

        network = {
          # wifi
          networkPanelView = "wifi";
          wifiDetailsViewMode = "grid";

          # bluetooth
          bluetoothAutoConnect = true;
          bluetoothHideUnnamedDevices = false;
          disableDiscoverability = false;
          bluetoothDetailsViewMode = "grid";

          bluetoothRssiPollingEnabled = false;
          bluetoothRssiPollIntervalMs = 60000;
        };

        location = {
          name = "Berlin";
          autoLocate = false;

          showWeekNumberInCalendar = true;
          showCalendarEvents = true;
          showCalendarWeather = true;
          analogClockInCalendar = false;

          hideWeatherTimezone = false;
          hideWeatherCityName = false;
          weatherEnabled = true;
          weatherShowEffects = true;
          weatherTaliaMascotAlways = false;

          firstDayOfWeek = -1;
          useFahrenheit = false;
          use12hourFormat = false;
        };

        calendar = {
          cards = [
            {
              enabled = true;
              id = "calendar-header-card";
            }
            {
              enabled = true;
              id = "calendar-month-card";
            }
            {
              enabled = true;
              id = "weather-card";
            }
          ];
        };

        notifications = {
          # general
          enabled = true;
          location = "top_right";
          density = "default";
          overlayLayer = true;
          clearDismissed = true;
          enableMarkdown = true;
          backgroundOpacity = 1;

          # timing
          respectExpireTimeout = true;
          lowUrgencyDuration = 3;
          normalUrgencyDuration = 8;
          criticalUrgencyDuration = 15;

          # history
          saveToHistory = {
            low = true;
            normal = true;
            critical = true;
          };

          # audio
          sounds = {
            enabled = false;
            volume = 0.5;

            separateSounds = false;
            criticalSoundFile = "";
            normalSoundFile = "";
            lowSoundFile = "";

            excludedApps = "discord,firefox,chrome,chromium,edge";
          };

          # hardware
          enableMediaToast = false;
          enableKeyboardLayoutToast = true;
          enableBatteryToast = true;

          # monitors
          monitors = [ ];
        };

        osd = {
          enabled = true;
          location = "bottom_left";
          overlayLayer = true;

          autoHideMs = 2000;
          backgroundOpacity = 1;

          enabledTypes = [
            0
            1
            2
            3
          ];
        };

        ui = {
          fontDefault = "Roboto";
          fontFixed = "JetBrainsMono NF";
          fontDefaultScale = 1;
          fontFixedScale = 1;

          panelBackgroundOpacity = 1;
          panelsAttachedToBar = true;

          tooltipsEnabled = true;
          scrollbarAlwaysVisible = false;
          boxBorderEnabled = true;
          translucentWidgets = false;

          settingsPanelMode = "attached";
          settingsPanelSideBarCardStyle = false;
        };

        wallpaper = {
          enabled = true;
          overviewEnabled = true;
          directory = "${config.home.homeDirectory}/Pictures/Wallpapers";

          # appearance
          fillMode = "crop";
          fillColor = "#000000";
          solidColor = "#1a1a2e";
          useSolidColor = false;
          useOriginalImages = false;

          # monitors
          viewMode = "single";
          panelPosition = "follow_bar";
          setWallpaperOnAllMonitors = true;
          enableMultiMonitorDirectories = true;

          # file management
          monitorDirectories = [ ];
          favorites = [ ];
          sortOrder = "name";
          showHiddenFiles = false;
          hideWallpaperFilenames = false;
          useWallhaven = false;

          # effects
          overviewBlur = 0.4;
          overviewTint = 0.6;
          skipStartupTransition = false;
          linkLightAndDarkWallpapers = true;

          transitionDuration = 1500;
          transitionEdgeSmoothness = 0.05;
          transitionType = [
            "stripes"
            "honeycomb"
          ];

          # automation
          automationEnabled = false;
          randomIntervalSec = 300;
          wallpaperChangeMode = "random";
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

        plugins = {
          autoUpdate = true;
          notifyUpdates = true;
        };

        idle = {
          enabled = false;

          screenOffTimeout = 600;
          lockTimeout = 300;
          suspendTimeout = 1800;

          fadeDuration = 5;

          screenOffCommand = "${lib.getExe pkgConfig.hyprlock}";
          lockCommand = "${lib.getExe pkgConfig.hyprlock}";
          suspendCommand = "${lib.getExe pkgConfig.hyprlock}; sleep 3; systemctl suspend";

          resumeScreenOffCommand = "";
          resumeLockCommand = "";
          resumeSuspendCommand = "";

          customCommands = "[]";
        };

        # run commands on system events
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

          colorGeneration = "";
        };
      };
    };
  };
}
