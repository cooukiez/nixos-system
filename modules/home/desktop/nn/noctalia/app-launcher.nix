/*
  modules/home/desktop/nn/noctalia/app-launcher.nix

  created by ludw
  on 2026-01-29
*/

{
  position = "center";
  sortByMostUsed = true;
  viewMode = "grid";

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
  # todo: put in screenshot tool
  screenshotAnnotationTool = "";

  showCategories = true;
  # will add dark background to icons
  showIconBackground = false;

  useApp2Unit = false;
}
