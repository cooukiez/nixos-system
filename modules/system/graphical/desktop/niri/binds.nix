/*
  modules/home/desktop/nn/niri/binds.nix
  Updated: Corrected all .spawn values to be lists.
*/

{
  config,
  pkgs,
  lib,
  ...
}:
let
  scripts = import ./scripts.nix { inherit pkgs; };

  split = str: builtins.filter builtins.isString (builtins.split " " str);

  mkNoctaliaBind = title: cmdStr: {
    spawn = [
      "${lib.getExe pkgs.noctalia}"
      "ipc"
      "call"
    ]
    ++ (split cmdStr);

    _attrs.hotkey-overlay-title = title;
  };

  mkExecBind = title: cmdStr: {
    spawn = split cmdStr;
    _attrs.hotkey-overlay-title = title;
  };
in
{
  "XF86AudioRaiseVolume" = mkNoctaliaBind "Raise Volume" "volume increase";
  "XF86AudioLowerVolume" = mkNoctaliaBind "Lower Volume" "volume decrease";
  "XF86AudioMute" = mkNoctaliaBind "Mute Sound" "volume muteOutput";
  "XF86AudioMicMute" = mkNoctaliaBind "Mute Microphone" "volume muteInput";

  "Mod+TouchpadScrollDown" = mkNoctaliaBind "Scroll Volume Up" "volume increase";
  "Mod+TouchpadScrollUp" = mkNoctaliaBind "Scroll Volume Down" "volume decrease";

  "XF86MonBrightnessUp" = mkNoctaliaBind "Increase Brightness" "brightness increase";
  "XF86MonBrightnessDown" = mkNoctaliaBind "Decrease Brightness" "brightness decrease";

  "Mod+Shift+TouchpadScrollDown" =
    mkExecBind "Scroll Brightness Up" "${lib.getExe pkgs.brightnessctl} set 2%+";
  "Mod+Shift+TouchpadScrollUp" =
    mkExecBind "Scroll Brightness Down" "${lib.getExe pkgs.brightnessctl} set 2%-";

  "XF86RFKill" = mkNoctaliaBind "Airplane Mode" "wifi disable";
  "XF86Bluetooth" = mkNoctaliaBind "Toggle Bluetooth" "bluetooth toggle";

  "Mod+I" = mkNoctaliaBind "Open Settings" "settings toggle";

  "Mod+E" = mkExecBind "Open File Manager" "${lib.getExe config.pkgConfig.nautilus}";
  "Mod+Q" = mkExecBind "Open Terminal" "${lib.getExe config.pkgConfig.kitty}";
  "Mod+Shift+F" = mkExecBind "Open Firefox" "${lib.getExe config.pkgConfig.firefox}";
  "Mod+Shift+D" = mkExecBind "Open Zen-Browser" "${lib.getExe config.pkgConfig.zen-browser}";
  "Mod+Shift+C" = mkExecBind "Open VSCode" "${lib.getExe config.pkgConfig.vscode}";

  "Mod+F1" = mkNoctaliaBind "Toggle Cheatsheet" "plugin:keybind-cheatsheet toggle";
  "Mod+D" = mkNoctaliaBind "Application Launcher" "launcher toggle";
  "Mod+R" = mkNoctaliaBind "Command Runner" "launcher command";
  "Mod+Shift+E" = mkNoctaliaBind "Emoji Selector" "launcher emoji";
  "Mod+Shift+V" = mkNoctaliaBind "Clipboard History" "launcher clipboard";
  "Mod+X" = mkNoctaliaBind "Control Center" "controlCenter toggle";
  "Mod+P" = mkNoctaliaBind "Session Menu" "sessionMenu toggle";

  "Mod+L" = mkExecBind "Lock Screen" "${lib.getExe config.pkgConfig.hyprlock}";

  "Mod+Shift+L" = mkExecBind "Apply low resolution" "${scripts.lowRes}/bin/low-res";
  "Mod+Shift+H" = mkExecBind "Apply high resolution" "${scripts.highRes}/bin/high-res";

  "Print" = mkExecBind "Screenshot full screen" "${scripts.screenshotFull}/bin/screenshot-full";
  "Mod+Print" = mkExecBind "Screenshot region" "${scripts.screenshotRegion}/bin/screenshot-region";

  "Mod+F2" = mkExecBind "Record full screen" "${scripts.recordFull}/bin/record-full";
  "Mod+F3" = mkExecBind "Record region" "${scripts.recordRegion}/bin/record-region";
  "Mod+F4" = mkExecBind "Stop all recordings" "${scripts.recordStop}/bin/record-stop";

  "Mod+C".close-window = null;
  "Mod+H".maximize-column = null;
  "Mod+S".toggle-overview = null;

  "Mod+WheelScrollDown".focus-workspace-down = null;
  "Mod+WheelScrollUp".focus-workspace-up = null;
  "Mod+WheelScrollRight".focus-column-right = null;
  "Mod+WheelScrollLeft".focus-column-left = null;

  "Mod+Left".focus-column-or-monitor-left = null;
  "Mod+Right".focus-column-or-monitor-right = null;
  "Mod+Up".focus-window-or-workspace-up = null;
  "Mod+Down".focus-window-or-workspace-down = null;

  "Mod+Shift+Return".move-window-to-monitor-next = null;

  "Mod+Shift+Left".move-column-left-or-to-monitor-left = null;
  "Mod+Shift+Right".move-column-right-or-to-monitor-right = null;
  "Mod+Shift+Up".move-window-up-or-to-workspace-up = null;
  "Mod+Shift+Down".move-window-down-or-to-workspace-down = null;

  "Mod+V".toggle-window-floating = null;
  "Mod+F".fullscreen-window = null;
  "Mod+G".toggle-windowed-fullscreen = null;

  "Ctrl+Alt+Left".consume-or-expel-window-left = null;
  "Ctrl+Alt+Right".consume-or-expel-window-right = null;

  "Ctrl+Alt+Q".switch-preset-column-width = null;
  "Ctrl+Alt+A".switch-preset-window-height = null;
  "Ctrl+Alt+S".expand-column-to-available-width = null;

  "Mod+W".toggle-column-tabbed-display = null;

  "Mod+Shift+M" = {
    quit = {
      _attrs.skip-confirmation = true;
    };

    _attrs.hotkey-overlay-title = "Quit Compositor";
  };
}
// builtins.foldl' (acc: elem: acc // elem) { } (
  map (i: {
    "Mod+${builtins.toString i}".focus-workspace = i;
    "Mod+Shift+${builtins.toString i}".move-column-to-workspace = i;

  }) (lib.genList (x: x) 10)
)
