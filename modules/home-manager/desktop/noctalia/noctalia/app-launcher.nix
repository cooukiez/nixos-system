/*
  modules/home-manager/desktop/noctalia/noctalia/app-launcher.nix

  created by ludw
  on 2026-01-27
*/


{
  position = "center";
  sortByMostUsed = true;
  viewMode = "grid";
  customLaunchPrefix = "";
  customLaunchPrefixEnabled = false;

  autoPasteClipboard = false;
  clipboardWrapText = true;
  enableClipPreview = true;
  enableClipboardHistory = true;

  enableSettingsSearch = true;

  pinnedApps = [
    "firefox"
    "code"
    "org.gnome.Nautilus"
    "spotify"
  ];

  terminalCommand = "kitty -e";
  screenshotAnnotationTool = "";

  showCategories = true;
  showIconBackground = false;

  useApp2Unit = false;
}
