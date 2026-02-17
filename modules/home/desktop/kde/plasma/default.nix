/*
  modules/home/desktop/kde/plasma/default.nix

  created by ludw
  on 2026-02-16
*/

{
  pkgs,
  ...
}:
let
  breezeChameleonDark = pkgs.fetchzip {
    url = "https://github.com/cooukiez/breeze-chameleon-dark-upstream/releases/download/latest/Breeze-Chameleon-Dark.tar.xz";
    sha256 = "sha256-18d1HcluLQbMcigaGn5tG01xzTug5sNyGZawot0zrG8=";
  };
in
{
  home.file.".local/share/icons/Breeze-Chameleon-Dark" = {
    source = breezeChameleonDark;
    recursive = true;
  };

  programs.plasma = {
    enable = true;

    panels = import ./panels.nix;
    shortcuts = import ./shortcuts.nix;
    dataFile = import ./data-file.nix;

    kscreenlocker.appearance.wallpaper = ./lockscreen.jpg;

    workspace = {
      enableMiddleClickPaste = false;
      clickItemTo = "select";

      theme = "breeze-dark";
      colorScheme = "BreezeDark";
      iconTheme = "Breeze Chameleon Dark";

      cursor = {
        cursorFeedback = "None";
        taskManagerFeedback = true;
        theme = "BreezeDark";
      };

      splashScreen.engine = "none";
      splashScreen.theme = "none";

      tooltipDelay = 1;
      wallpaper = ./wallpaper.jpg;
    };

    fonts = {
      fixedWidth = {
        family = "JetBrainsMono Nerd Font Mono";
        pointSize = 10;
      };
      general = {
        family = "Inter";
        pointSize = 10;
      };
      menu = {
        family = "Inter";
        pointSize = 10;
      };
      small = {
        family = "Inter";
        pointSize = 8;
      };
      toolbar = {
        family = "Inter";
        pointSize = 10;
      };
      windowTitle = {
        family = "Inter";
        pointSize = 10;
      };
    };

    krunner = {
      activateWhenTypingOnDesktop = true;
      historyBehavior = "enableSuggestions";
      position = "center";
      #       shortcuts.launch = "Meta+R";
      shortcuts.runCommandOnClipboard = "Shift+Enter";
    };

    kwin = {
      nightLight = {
        enable = true;
        mode = "times";
        time.evening = "21:00";
        time.morning = "06:30";
        temperature.night = 4000;
      };

      virtualDesktops = {
        number = 5;
        rows = 1;
      };

      titlebarButtons = {
        left = [
          "more-window-actions"
        ];
        right = [
          "minimize"
          "maximize"
          "close"
        ];
      };
    };

    session = {
      general.askForConfirmationOnLogout = false;
      sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    };

    #     powerdevil = {
    #       AC = {
    #         autoSuspend.action = "nothing";
    #         dimDisplay.enable = false;
    #         powerButtonAction = "shutDown";
    #         turnOffDisplay.idleTimeout = "never";
    #       };
    #       battery = {
    #         autoSuspend.action = "nothing";
    #         dimDisplay.enable = false;
    #         powerButtonAction = "shutDown";
    #         turnOffDisplay.idleTimeout = "never";
    #       };
    #     };

    spectacle = {
      shortcuts = {
        captureEntireDesktop = "Meta+Print";
        captureRectangularRegion = "Print";
        launch = "";
        recordRegion = "Alt+Print";
        recordScreen = "Meta+Alt+Print";
        recordWindow = "";
      };
    };

    configFile = {
      baloofilerc."Basic Settings"."Indexing-Enabled" = true;
      gwenviewrc.ThumbnailView.AutoplayVideos = true;
      kdeglobals = {
        General = {
          BrowserApplication = "firefox.desktop";
        };
        KDE = {
          AnimationDurationFactor = 0;
        };
      };
      klaunchrc.FeedbackStyle.BusyCursor = false;
      klipperrc.General.MaxClipItems = 8192;

      kwinrc = {
        Effect-overview.BorderActivate = 9;
        Effect-cube.BackgroundColor = "0,0,0";
        Effect-slide.SlideBackground = false;

        Plugins = {
          blurEnabled = true;
          dimscreenEnabled = false;
          krohnkiteEnabled = true;
          screenedgeEnabled = false;
          wobblywindowsEnabled = false;
        };

        "Round-Corners" = {
          ActiveOutlineAlpha = 255;
          ActiveOutlineUseCustom = false;
          ActiveOutlineUsePalette = true;
          AnimationDuration = 0;
          DisableOutlineTile = false;
          DisableRoundTile = false;
          InactiveCornerRadius = 5;
          InactiveOutlineAlpha = 255;
          InactiveOutlineUsePalette = true;
          InactiveSecondOutlineThickness = 0;
          OutlineThickness = 1;
          SecondOutlineThickness = 0;
          Size = 5;
          UseNativeDecorationShadows = false;
        };

        "Script-krohnkite" = {
          #           floatingClass = "org.freedesktop.impl.portal.desktop.kde";
          screenGapBetween = 8;
          screenGapBottom = 8;
          screenGapLeft = 8;
          screenGapRight = 8;
          screenGapTop = 48;
        };

        Windows = {
          DelayFocusInterval = 0;
          FocusPolicy = "FocusFollowsMouse";
        };
      };

      plasmanotifyrc = {
        DoNotDisturb = {
          WhenFullscreen = false;
          WhenScreenSharing = false;
          WhenScreensMirrored = false;
        };

        Notifications = {
          PopupPosition = "TopRight";
          PopupTimeout = 7000;
        };
      };

      plasmarc.OSD.Enabled = true;
      spectaclerc = {
        Annotations = {
          annotationToolType = 8;
          rectangleStrokeColor = "255,0,0";
        };

        General = {
          launchAction = "DoNotTakeScreenshot";
          showCaptureInstructions = false;
          useReleaseToCapture = true;
        };

        ImageSave.imageCompressionQuality = 100;
      };
    };

    window-rules = [
      {
        apply = {
          noborder = {
            value = true;
            apply = "initially";
          };
        };
        description = "Hide titlebar for kde apps";
        match = {
          window-class = {
            value = "dolphin|ark|kate|konsole|gwenview|discover|elisa|kcalc|infocenter|konversation|ktorrent|kolourpaint|krita|okular|settings|google-chrome|github-desktop";
            type = "regex";
          };

          window-types = [ "normal" ];
        };
      }
    ];
  };
}
