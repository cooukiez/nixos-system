/*
modules/home/desktop/nn/noctalia/app-launcher.nix

part of nixos system
created 2026-02-26 by ludw
*/
{
  # clipboard
  enableClipboardChips = true;
  enableClipboardHistory = true;
  enableClipboardSmartIcons = true;
  enableClipPreview = true;
  clipboardWrapText = true;
  autoPasteClipboard = false;
  clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
  clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";

  # application
  pinnedApps = [
    "firefox"
    "nemo"
    "signal"
  ];

  sortByMostUsed = true;
  showCategories = true;
  enableSettingsSearch = false;
  enableWindowsSearch = true;
  enableSessionSearch = true;

  # interface
  viewMode = "grid";
  position = "center";
  density = "default";
  overviewLayer = true;
  ignoreMouseInput = false;

  # icons
  iconMode = "tabler";
  showIconBackground = false;

  # external
  terminalCommand = "kitty -e";
  screenshotAnnotationTool = "pinta";

  # prefixes
  customLaunchPrefixEnabled = false;
  customLaunchPrefix = "";
}
