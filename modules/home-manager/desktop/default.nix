{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  # set gpg agent specific to KDE/Kwallet
  services.gpg-agent = {
    pinentry.package = lib.mkForce pkgs.kwalletcli;
    extraConfig = "pinentry-program ${pkgs.kwalletcli}/bin/pinentry-kwallet";
  };

  home.packages = with pkgs; [
#     python313Packages.kde-material-you-colors
    kde-rounded-corners
    kdePackages.krohnkite

    # better blur
    inputs.kwin-effects-better-blur-dx.packages.${pkgs.system}.default # Wayland
    inputs.kwin-effects-better-blur-dx.packages.${pkgs.system}.x11 # X11
  ];

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
      wallpaper = import ./wallpaper.nix;
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
      position = "top";
      shortcuts.launch = "Meta+R";
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
        floating = false;
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
              general = {
                enable = true;
                hideWidget = true;
              };

              panelBackground.originalBackground.hide = true; panelBackground.originalBackground.opacity = 0.0;
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
                  "plasmashell_microphone"
                  "org.kde.kscreen"
                  "org.kde.plasma.battery"
                  "org.kde.plasma.brightness"
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.diskquota"
                  "org.kde.plasma.manage-inputmethod"
                  "org.kde.plasma.printmanager"
                  "org.kde.plasma.bluetooth"
                  "org.kde.plasma.cameraindicator"
                  "org.kde.plasma.devicenotifier"
                  "org.kde.plasma.kclock_1x2"
                  "org.kde.plasma.keyboardlayout"
                  "org.kde.plasma.keyboardindicator"
                  "org.kde.plasma.mediacontroller"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.notifications"
                  "org.kde.plasma.volume"
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
                  fontWeight = 400;
                };
              };
            };
          }
          {
            name = "org.kde.plasma.marginsseparator";
          }
        ];
      }
      {
        location = "right";
        alignment = "center";
        height = 28;
        floating = true;
        hiding = "autohide";
        lengthMode = "fit";
        opacity = "translucent";
        widgets = [
          {
            kickerdash = {

            };
          }
        ];
      }
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
          "Meta+Alt+L"
        ];
        "LogOut" = [
          "Meta+Alt+Q"
        ];
      };

      "KDE Keyboard Layout Switcher" = {
        "Switch to Next Keyboard Layout" = "Meta+Space";
      };

      kwin = {
        "KrohnkiteMonocleLayout" = [ ];
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Switch to Desktop 7" = "Meta+7";
        "Window Close" = "Meta+C";
        "Window Fullscreen" = "Meta+F";
        "Window Move Center" = "Meta+Alt+C";
      };

      plasmashell = {
        "show-on-mouse-pos" = "";
      };

      "services/org.kde.dolphin.desktop"."_launch" = "Meta+E";
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

        Plugins = {
          blurEnabled = true;
          dimscreenEnabled = false;
          krohnkiteEnabled = true;
          screenedgeEnabled = false;
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
          screenGapBetween = 5;
          screenGapBottom = 5;
          screenGapLeft = 5;
          screenGapRight = 5;
          screenGapTop = 5;
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

      plasmarc.OSD.Enabled = false;
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

    dataFile = {
      "dolphin/view_properties/global/.directory"."Dolphin"."ViewMode" = 1;
      "dolphin/view_properties/global/.directory"."Settings"."HiddenFilesShown" = true;
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
            value = "org\.kde\.(dolphin|ark|kate|konsole|gwenview|discover|elisa|kcalc|infocenter|konversation|ktorrent|kolourpaint|krita|okular)";
            type = "regex";
          };

          window-types = [ "normal" ];
        };
      }
      {
        apply = {
          noborder = {
            value = true;
            apply = "initially";
          };
        };
        description = "Hide titlebar for system settings";
        match = {
          window-class = {
            value = "systemsettings";
            type = "substring";
          };

          window-types = [ "normal" ];
        };
      }
    ];
  };


  programs.kate = {
    enable = true;

    editor = {
      brackets.automaticallyAddClosing = true;
      brackets.highlightMatching = true;
      brackets.highlightRangeBetween = true;

      indent.autodetect = false;
      indent.width = 2;
      indent.replaceWithSpaces = true;
      indent.showLines = true;
      tabWidth = 4;
    };
  };
}
