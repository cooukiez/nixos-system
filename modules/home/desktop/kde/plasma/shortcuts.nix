/*
  modules/home/desktop/kde/plasma/shortcuts.nix

  created by ludw
  on 2026-02-18
*/

{
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
    ExposeAll = [
      "Meta+O"
      "Launch (C)"
    ];
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

    "Walk Through Windows" = [
      "Meta+Tab"
      "Alt+Tab"
    ];
    "Walk Through Windows (Reverse)" = [
      "Meta+Shift+Tab"
      "Alt+Shift+Tab"
    ];

    "Window Quick Tile Bottom" = "Meta+Down";
    "Window Quick Tile Bottom Left" = [ ];
    "Window Quick Tile Bottom Right" = [ ];
    "Window Quick Tile Left" = "Meta+Left";
    "Window Quick Tile Right" = "Meta+Right";
    "Window Quick Tile Top" = "Meta+Up";
    "Window Quick Tile Top Left" = [ ];
    "Window Quick Tile Top Right" = [ ];

    "Window Close" = [
      "Meta+C"
      "Alt+F4"
    ];
    "Kill Window" = [
      "Meta+Shift+C"
      "Alt+Shift+F4"
    ];
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
}
