[
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
      {
        plasmaPanelColorizer = {
          general.enable = true;
          general.hideWidget = true;
        };
      }
    ];
  }
]
