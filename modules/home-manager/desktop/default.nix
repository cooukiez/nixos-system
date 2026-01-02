{ inputs, pkgs, lib, ... }:
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
      iconTheme = "Papirus Dark";

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
  };
}
