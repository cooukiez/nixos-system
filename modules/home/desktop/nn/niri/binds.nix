{
  lib,
  ...
}:
with lib.niri.actions;
let
  wpctl = spawn "wpctl";
  brightnessctl = spawn "brightnessctl";
  noctalia-ipc = spawn "noctalia-shell" "ipc" "call";

  # entire command for fullscreen screenshot
  screenshot-full = spawn "bash" "-c" ''
    mkdir -p ~/Pictures/Screenshots
    f=~/Pictures/Screenshots/Screenshot-$(date +%Y-%m-%d_%H-%M-%S-%3N).png
    grim "$f" &&
    wl-copy < "$f" &&
    notify-send --app-name=Screencapture Screenshot "Screenshot of entire screen captured." -i "$f"
  '';

  # entire command for region screenshot
  screenshot-region = spawn "bash" "-c" ''
    mkdir -p ~/Pictures/Screenshots
    f=~/Pictures/Screenshots/Screenshot-$(date +%Y-%m-%d_%H-%M-%S-%3N).png
    grim -g "$(slurp -d)" "$f" &&
    wl-copy < "$f" &&
    notify-send --app-name=Screencapture Screenshot "Screenshot of selected region captured." -i "$f"
  '';

  # entire command for fullscreen recording
  record-full = spawn "bash" "-c" ''
    mkdir -p ~/Videos/Captures
    f=~/Videos/Captures/Recording-$(date +%Y-%m-%d_%H-%M-%S-%3N).mp4
    wf-recorder -f "$f"
    wl-copy "$f"
    notify-send --app-name=Screencapture "Recording saved" "Screen recording saved." -i video-x-generic
  '';

  # entire command for region recording
  record-region = spawn "bash" "-c" ''
    mkdir -p ~/Videos/Captures
    f=~/Videos/Captures/Recording-$(date +%Y-%m-%d_%H-%M-%S-%3N).mp4
    wf-recorder -g "$(slurp)" -f "$f"
    wl-copy "$f"
    notify-send --app-name=Screencapture "Recording saved" "Screen recording saved." -i video-x-generic
  '';

  # entire command to stop all recordings
  record-stop = spawn "bash" "-c" ''
    pkill -INT wf-recorder
    notify-send --app-name=Screencapture "Recording stopped" "Recording has been stopped." -i video-x-generic
  '';
in
{
  "XF86AudioRaiseVolume".action = wpctl "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
  "XF86AudioRaiseVolume".hotkey-overlay.title = "Raise Volume";
  "XF86AudioLowerVolume".action = wpctl "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
  "XF86AudioLowerVolume".hotkey-overlay.title = "Lower volume";

  "XF86AudioMute".action = wpctl "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
  "XF86AudioMute".hotkey-overlay.title = "Mute sound";
  "XF86AudioMicMute".action = wpctl "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
  "XF86AudioMicMute".hotkey-overlay.title = "Mute microphone";

  "Mod+TouchpadScrollDown".action = wpctl "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+";
  "Mod+TouchpadScrollDown".hotkey-overlay.title = "Scroll volume up";
  "Mod+TouchpadScrollUp".action = wpctl "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-";
  "Mod+TouchpadScrollUp".hotkey-overlay.title = "Scroll volume down";

  "XF86MonBrightnessUp".action = brightnessctl "set" "5%+";
  "XF86MonBrightnessUp".hotkey-overlay.title = "Increase brightness";
  "XF86MonBrightnessDown".action = brightnessctl "set" "5%-";
  "XF86MonBrightnessDown".hotkey-overlay.title = "Decrease brightness";

  "Mod+Shift+TouchpadScrollDown".action = brightnessctl "set" "2%+";
  "Mod+Shift+TouchpadScrollDown".hotkey-overlay.title = "Scroll brightness up";
  "Mod+Shift+TouchpadScrollUp".action = brightnessctl "set" "2%-";
  "Mod+Shift+TouchpadScrollUp".hotkey-overlay.title = "Scroll brightness down";

  "XF86RFKill".action = noctalia-ipc "wifi" "disable";
  "XF86RFKill".hotkey-overlay.title = "Airplane mode";

  "XF86Bluetooth".action = noctalia-ipc "bluetooth" "toggle";
  "XF86Bluetooth".hotkey-overlay.title = "Toggle bluetooth";

  "XF86Tools".action = noctalia-ipc "settings" "toggle";
  "XF86Tools".hotkey-overlay.title = "Open settings";

  "Mod+E".action.spawn = [ "nautilus" ];
  "Mod+E".hotkey-overlay.title = "Open file manager";
  "Mod+Q".action.spawn = [ "kitty" ];
  "Mod+Q".hotkey-overlay.title = "Open terminal";
  "Mod+Shift+F".action.spawn = [ "firefox" ];
  "Mod+Shift+F".hotkey-overlay.title = "Open firefox";
  "Mod+Shift+D".action.spawn = [ "zen-browser" ];
  "Mod+Shift+D".hotkey-overlay.title = "Open zen-browser";
  "Mod+Shift+C".action.spawn = [ "code" ];
  "Mod+Shift+C".hotkey-overlay.title = "Open vscode";

  "Mod+F1".action = noctalia-ipc "plugin:keybind-cheatsheet" "toggle";
  "Mod+F1".hotkey-overlay.title = "Toggle this cheatsheet";

  "Mod+A".action = noctalia-ipc "launcher" "toggle";
  "Mod+A".hotkey-overlay.title = "Open application launcher";

  "Mod+R".action = noctalia-ipc "launcher" "command";
  "Mod+R".hotkey-overlay.title = "Open command runner";

  "Mod+Shift+E".action = noctalia-ipc "launcher" "emoji";
  "Mod+Shift+E".hotkey-overlay.title = "Open emoji selector";

  "Mod+Shift+V".action = noctalia-ipc "launcher" "clipboard";
  "Mod+Shift+V".hotkey-overlay.title = "Open clipboard history";

  "Mod+X".action = noctalia-ipc "controlCenter" "toggle";
  "Mod+X".hotkey-overlay.title = "Open control center";

  "Mod+I".action = noctalia-ipc "sessionMenu" "toggle";
  "Mod+I".hotkey-overlay.title = "Open session menu";

  "Mod+Shift+L".action = noctalia-ipc "sessionMenu" "lockAndSuspend";
  "Mod+Shift+L".hotkey-overlay.title = "Lock and suspend";

  "Print".action = screenshot-full;
  "Mod+Print".action = screenshot-region;

  "Mod+F2".action = record-full;
  "Mod+F3".action = record-region;
  "Mod+F4".action = record-stop;

  "Mod+C".action = close-window;
  "Mod+H".action = maximize-column;
  "Mod+S".action = toggle-overview;

  "Mod+1".action.focus-workspace = 1;
  "Mod+2".action.focus-workspace = 2;
  "Mod+3".action.focus-workspace = 3;
  "Mod+4".action.focus-workspace = 4;
  "Mod+5".action.focus-workspace = 5;
  "Mod+6".action.focus-workspace = 6;
  "Mod+7".action.focus-workspace = 7;
  "Mod+8".action.focus-workspace = 8;
  "Mod+9".action.focus-workspace = 9;
  "Mod+0".action.focus-workspace = 10;

  "Mod+WheelScrollDown".action = focus-workspace-down;
  "Mod+WheelScrollUp".action = focus-workspace-up;
  "Mod+WheelScrollRight".action = focus-column-right;
  "Mod+WheelScrollLeft".action = focus-column-left;

  "Mod+Shift+1".action.move-column-to-workspace = 1;
  "Mod+Shift+2".action.move-column-to-workspace = 2;
  "Mod+Shift+3".action.move-column-to-workspace = 3;
  "Mod+Shift+4".action.move-column-to-workspace = 4;
  "Mod+Shift+5".action.move-column-to-workspace = 5;
  "Mod+Shift+6".action.move-column-to-workspace = 6;
  "Mod+Shift+7".action.move-column-to-workspace = 7;
  "Mod+Shift+8".action.move-column-to-workspace = 8;
  "Mod+Shift+9".action.move-column-to-workspace = 9;
  "Mod+Shift+0".action.move-column-to-workspace = 10;

  "Mod+Left".action = focus-column-or-monitor-left;
  "Mod+Right".action = focus-column-or-monitor-right;
  "Mod+Up".action = focus-window-or-workspace-up;
  "Mod+Down".action = focus-window-or-workspace-down;

  "Mod+Shift+Return".action = move-window-to-monitor-next;

  "Mod+Shift+Left".action = move-column-left-or-to-monitor-left;
  "Mod+Shift+Right".action = move-column-right-or-to-monitor-right;
  "Mod+Shift+Up".action = move-window-up-or-to-workspace-up;
  "Mod+Shift+Down".action = move-window-down-or-to-workspace-down;

  "Mod+V".action = toggle-window-floating;
  "Mod+F".action = fullscreen-window;
  "Mod+G".action = toggle-windowed-fullscreen;

  "Ctrl+Alt+Left".action = consume-or-expel-window-left;
  "Ctrl+Alt+Right".action = consume-or-expel-window-right;

  "Ctrl+Alt+Q".action = switch-preset-column-width;
  "Ctrl+Alt+A".action = switch-preset-window-height;
  "Ctrl+Alt+S".action = expand-column-to-available-width;

  "Mod+Shift+M".action.quit.skip-confirmation = true;
  "Mod+Shift+M".hotkey-overlay.title = "Quit compositor";

  "Mod+W".action = toggle-column-tabbed-display;
}
