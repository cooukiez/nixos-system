/*
  modules/home/desktop/nn/noctalia/app-launcher.nix

  created by ludw
  on 2026-02-26
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
    "code"
    "org.gnome.Nautilus"
    "obsidian"
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
