{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./input-gestures.nix
    ./packages.nix

    inputs.plasma-manager.homeModules.plasma-manager
  ];

  # set gpg agent specific to KDE/Kwallet
  services.gpg-agent = {
    pinentry.package = lib.mkForce pkgs.kwalletcli;
    extraConfig = "pinentry-program ${pkgs.kwalletcli}/bin/pinentry-kwallet";
  };

  # kde internal packages
  home.packages = with pkgs; [
#     python313Packages.kde-material-you-colors
    kde-rounded-corners
    kdePackages.krohnkite
  ];

  # install:
  # icons -> Breeze Chameleon Dark

  programs.plasma = {
    enable = true;

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

    panels = [
      {
        location = "top";
        alignment = "left";
        height = 32;
        floating = true;
        hiding = "windowsgobelow";
        lengthMode = "fill";
        opacity = "translucent";
        widgets = [
          {
            kickoff = {
              settings = {
                showButtonsFor = "power";
                showActionButtonCaptions = false;
              };
            };
          }
          {
            appMenu = {

            };
          }
          {
            panelSpacer = {
              settings = {
                expanding = true;
              };
            };
          }
          {
            plasmaPanelColorizer = {
              general.enable = true;
              general.hideWidget = true;
            };
          }
          {
            systemTray = {
              icons.scaleToFit = false;
              icons.spacing = "small";
              items = {
                showAll = false;
                shown = [ ];
                hidden = [
                  "org.kde.plasma.weather"
                ];
                extra = [
                  "org.kde.kscreen"
                  "org.kde.plasma.battery"
                  "org.kde.plasma.bluetooth"
                  "org.kde.plasma.brightness"
                  "org.kde.plasma.cameraindicator"
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.devicenotifier"
                  "org.kde.plasma.diskquota"
                  "org.kde.plasma.keyboardindicator"
                  "org.kde.plasma.keyboardlayout"
                  "org.kde.plasma.kclock_1x2"
                  "org.kde.plasma.manage-inputmethod"
                  "org.kde.plasma.mediacontroller"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.notifications"
                  "org.kde.plasma.printmanager"
                  "org.kde.plasma.volume"
                  "plasmashell_microphone"
                  "xdg-desktop-portal-kde"
                ];
                configs = {
                  "org.kde.plasma.notifications".config = {
                    Shortcuts = {
                      global = "Meta+N";
                    };
                  };
                };
              };
            };
          }
          {
            name = "org.kde.plasma.marginsseparator";
          }
          {
            digitalClock = {
              settings = {
                Appearance = {
                  use24hFormat = 2;
                  dateDisplayFormat = "BesideTime";
                  dateFormat = "custom";
                  customDateFormat = "ddd d ";
                  autoFontAndSize = false;
                  fontStyleName = "Inter";
                  fontSize = 6;
                  fontWeight = 300;
                };
              };
            };
          }
          {
            name = "org.kde.plasma.marginsseparator";
          }
        ];
      }
#       {
#         location = "right";
#         alignment = "center";
#         height = 28;
#         floating = true;
#         hiding = "autohide";
#         lengthMode = "fit";
#         opacity = "translucent";
#         widgets = [
#           {
#             kickerdash = {
#
#             };
#           }
#           {
#             plasmaPanelColorizer = {
#               general.enable = true;
#               general.hideWidget = true;
#             };
#           }
#         ];
#       }
    ];

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

    shortcuts = {
      ksmserver = {
        "Lock Session" = [
          "Screensaver"
          "Meta+Shift+L"
        ];
        "LogOut" = [
          "Meta+Shift+Q"
        ];
        "Reboot" = [
          "Meta+Shift+R"
        ];
        "Shut Down" = [
          "Meta+Shift+P"
        ];
      };

      "KDE Keyboard Layout Switcher" = {
        "Switch to Next Keyboard Layout" = "Meta+Space";
      };

      kwin = {
        Cube = "Meta+U";

        Expose = "Ctrl+F9";
        ExposeClass = "Ctrl+F10";
        ExposeAll = ["Meta+O" "Launch (C)"];
        ExposeClassCurrentDesktop = [ ];

        Overview = "Meta+W";
        "Grid View" = "Meta+G";

        KrohnkiteMonocleLayout = [ ];
        KrohnkiteFloatAll = [ ];
        KrohnkiteRotate = [ ];
        KrohnkiteSetMaster = [ ];

        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Switch to Desktop 7" = "Meta+7";
        "Switch to Desktop 8" = "Meta+8";
        "Switch to Desktop 9" = "Meta+9";
        "Switch to Desktop 10" = "Meta+0";

        "Window to Desktop 1" = "Meta+Shift+1";
        "Window to Desktop 2" = "Meta+Shift+2";
        "Window to Desktop 3" = "Meta+Shift+3";
        "Window to Desktop 4" = "Meta+Shift+4";
        "Window to Desktop 5" = "Meta+Shift+5";
        "Window to Desktop 6" = "Meta+Shift+6";
        "Window to Desktop 7" = "Meta+Shift+7";
        "Window to Desktop 8" = "Meta+Shift+8";
        "Window to Desktop 9" = "Meta+Shift+9";
        "Window to Desktop 10" = "Meta+Shift+0";

        "Switch to Next Desktop" = [ ];
        "Switch to Previous Desktop" = [ ];

        "Switch to Next Screen" = [ ];
        "Switch to Previous Screen" = [ ];

        "Switch One Desktop Down" = "Meta+Down";
        "Switch One Desktop Up" = "Meta+Up";
        "Switch One Desktop to the Left" = "Meta+Left";
        "Switch One Desktop to the Right" = "Meta+Right";

        "Window One Desktop Down" = "Meta+Shift+Down";
        "Window One Desktop Up" = "Meta+Shift+Up";
        "Window One Desktop to the Left" = "Meta+Shift+Left";
        "Window One Desktop to the Right" = "Meta+Shift+Right";

        "Switch to Screen Above" = [ ];
        "Switch to Screen Below" = [ ];
        "Switch to Screen to the Left" = [ ];
        "Switch to Screen to the Right" = [ ];

        "Window One Screen Down" = [ ];
        "Window One Screen Up" = [ ];
        "Window One Screen to the Left" = [ ];
        "Window One Screen to the Right" = [ ];


        "Window to Next Desktop" = [ ];
        "Window to Next Screen" = [ ];
        "Window to Previous Desktop" = [ ];
        "Window to Previous Screen" = [ ];

        "Switch Window Down" = "Meta+Alt+Down";
        "Switch Window Left" = "Meta+Alt+Left";
        "Switch Window Right" = "Meta+Alt+Right";
        "Switch Window Up" = "Meta+Alt+Up";

        "Walk Through Windows" = ["Meta+Tab" "Alt+Tab"];
        "Walk Through Windows (Reverse)" = ["Meta+Shift+Tab" "Alt+Shift+Tab"];

        "Window Quick Tile Bottom" = "Meta+Down";
        "Window Quick Tile Bottom Left" = [ ];
        "Window Quick Tile Bottom Right" = [ ];
        "Window Quick Tile Left" = "Meta+Left";
        "Window Quick Tile Right" = "Meta+Right";
        "Window Quick Tile Top" = "Meta+Up";
        "Window Quick Tile Top Left" = [ ];
        "Window Quick Tile Top Right" = [ ];

        "Window Close" = ["Meta+C" "Alt+F4"];
        "Kill Window" = ["Meta+Shift+C" "Alt+Shift+F4"];
        "Show Desktop" = "Meta+D";
        "Window Fullscreen" = "Meta+F";
        "Window Move Center" = "Meta+Alt+C";

        "Window Operations Menu" = "Alt+F3";

        disableInputCapture = [ ];
      };

      plasmashell = {
        "activate task manager entry 1" = [ ];
        "activate task manager entry 2" = [ ];
        "activate task manager entry 3" = [ ];
        "activate task manager entry 4" = [ ];
        "activate task manager entry 5" = [ ];
        "activate task manager entry 6" = [ ];
        "activate task manager entry 7" = [ ];
        "activate task manager entry 8" = [ ];
        "activate task manager entry 9" = [ ];
        "activate task manager entry 10" = [ ];

        "manage activities" = "Meta+A";

        "next activity" = [ ];
        "previous activity" = [ ];

        show-on-mouse-pos = [ ];
      };

      yakuake.toggle-window-state = "F12";

      "services/org.kde.krunner.desktop"."_launch" = "Meta+R";
      "services/org.kde.dolphin.desktop"."_launch" = "Meta+E";
      "services/org.kde.konsole.desktop"."_launch" = "Meta+Q";
      "firefox.desktop"."_launch" = "Meta+Shift+F";
    };


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
            value = "dolphin|ark|kate|konsole|gwenview|discover|elisa|kcalc|infocenter|konversation|ktorrent|kolourpaint|krita|okular|settings|google-chrome";
            type = "regex";
          };

          window-types = [ "normal" ];
        };
      }
    ];


    dataFile = {
      "dolphin/view_properties/global/.directory"."Dolphin"."ViewMode" = 1;
      "dolphin/view_properties/global/.directory"."Settings"."HiddenFilesShown" = true;

      "kate/anonymous.katesession"."Kate Plugins".bookmarksplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".cmaketoolsplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".compilerexplorer = false;
      "kate/anonymous.katesession"."Kate Plugins".eslintplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".externaltoolsplugin = true;
      "kate/anonymous.katesession"."Kate Plugins".formatplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katebacktracebrowserplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katebuildplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katecloseexceptplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katecolorpickerplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katectagsplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katefilebrowserplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katefiletreeplugin = true;
      "kate/anonymous.katesession"."Kate Plugins".kategdbplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".kategitblameplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katekonsoleplugin = true;
      "kate/anonymous.katesession"."Kate Plugins".kateprojectplugin = true;
      "kate/anonymous.katesession"."Kate Plugins".katereplicodeplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katesearchplugin = true;
      "kate/anonymous.katesession"."Kate Plugins".katesnippetsplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katesqlplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katesymbolviewerplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katexmlcheckplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katexmltoolsplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".keyboardmacrosplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".ktexteditorpreviewplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".latexcompletionplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".lspclientplugin = true;
      "kate/anonymous.katesession"."Kate Plugins".openlinkplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".rainbowparens = false;
      "kate/anonymous.katesession"."Kate Plugins".rbqlplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".tabswitcherplugin = true;
      "kate/anonymous.katesession"."Kate Plugins".templateplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".textfilterplugin = true;
    };
  };
}
