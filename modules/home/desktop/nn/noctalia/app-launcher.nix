/*
  modules/home/desktop/nn/noctalia/app-launcher.nix

  created by ludw
  on 2026-02-17
*/

{
  position = "center";
  sortByMostUsed = true;
  # alternative: grid
  viewMode = "list";

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
    "obsidian"
    "signal"
    # "thunderbird"
    # "github-desktop"
  ];

  terminalCommand = "kitty -e";
  # todo: put in screenshot tool
  screenshotAnnotationTool = "";

  showCategories = true;
  # will add dark background to icons
  showIconBackground = false;

  useApp2Unit = false;
}
