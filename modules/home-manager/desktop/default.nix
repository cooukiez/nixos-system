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

  programs.plasma = {
    enable = true;

    workspace = {
      enableMiddleClickPaste = false;
      clickItemTo = "select";

      theme = "breeze-dark";
      colorScheme = "BreezeDark";
      iconTheme = "breeze-dark";

      cursor = {
        cursorFeedback = "None";
        taskManagerFeedback = true;
        theme = "BreezeDark";
      };

      splashScreen.engine = "none";
      splashScreen.theme = "none";

      tooltipDelay = 1;
      #wallpaper = "${config.wallpaper}";
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

    krunner.activateWhenTypingOnDesktop = true;

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
        height = 28;
        lengthMode = "fill";
        opacity = "translucent";
        widgets = [
          {
            kickoff = {

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
            systemTray = {
              icons.scaleToFit = false;
              icons.spacing = "small";
              items = {
                showAll = false;
                shown = [ ];
                hidden = [ ];
                extra = [
                  "plasmashell_microphone"
                  "org.kde.kscreen"
                  "org.kde.plasma.battery"
                  "org.kde.plasma.bluetooth"
                  "org.kde.plasma.brightness"
                  "org.kde.plasma.cameraindicator"
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.devicenotifier"
                  "org.kde.plasma.diskquota"
                  "org.kde.plasma.kclock_1x2"
                  "org.kde.plasma.keyboardlayout"
                  "org.kde.plasma.keyboardindicator"
                  "org.kde.plasma.manage-inputmethod"
                  "org.kde.plasma.mediacontroller"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.notifications"
                  "org.kde.plasma.printmanager"
                  "org.kde.plasma.volume"
                  "org.kde.plasma.weather"
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
  };
}
