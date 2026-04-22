/*
  modules/home/desktop/nn/niri/binds.nix
  Updated: Corrected all .spawn values to be lists.
*/

{
  pkgs,
  lib,
  ...
}:
let
  wpctl = [ "wpctl" ];
  brightnessctl = [ "brightnessctl" ];

  mkNoctaliaBind = title: commandList: {
    _attrs = {
      hotkey-overlay-title = title;
    };

    spawn = [
      "noctalia-shell"
      "ipc"
      "call"
    ]
    ++ commandList;
  };

  low-res-pkg = pkgs.writeShellScriptBin "niri-low-res" ''
    ${pkgs.niri}/bin/niri msg output "eDP-1" custom-mode "1920x1200@60.000"
    ${pkgs.niri}/bin/niri msg output "eDP-1" scale 1.0
    ${pkgs.libnotify}/bin/notify-send --app-name="Niri Compositor" "Screen resolution changed" "Changed monitor mode to 1920x1200@60."
  '';

  high-res-pkg = pkgs.writeShellScriptBin "niri-high-res" ''
    ${pkgs.niri}/bin/niri msg output "eDP-1" mode "3480x2160@60.000"
    ${pkgs.niri}/bin/niri msg output "eDP-1" scale 2.0
    ${pkgs.libnotify}/bin/notify-send --app-name="Niri Compositor" "Screen resolution changed" "Changed monitor mode to 3480x2160@60."
  '';

  screenshot-full-pkg = pkgs.writeShellScriptBin "niri-screenshot-full" ''
    mkdir -p ~/Pictures/Screenshots
    f=~/Pictures/Screenshots/Screenshot-$(date +%Y-%m-%d_%H-%M-%S-%3N).png
    ${pkgs.grim}/bin/grim "$f" && \
    ${pkgs.wl-clipboard}/bin/wl-copy < "$f" && \
    ${pkgs.libnotify}/bin/notify-send --app-name=Screencapture Screenshot "Captured" -i "$f"
  '';

  screenshot-region-pkg = pkgs.writeShellScriptBin "niri-screenshot-region" ''
    mkdir -p ~/Pictures/Screenshots
    f=~/Pictures/Screenshots/Screenshot-$(date +%Y-%m-%d_%H-%M-%S-%3N).png
    ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d)" "$f" && \
    ${pkgs.wl-clipboard}/bin/wl-copy < "$f" && \
    ${pkgs.libnotify}/bin/notify-send --app-name=Screencapture Screenshot "Captured region" -i "$f"
  '';

  record-full-pkg = pkgs.writeShellScriptBin "niri-record-full" ''
    mkdir -p ~/Videos/Captures
    f=~/Videos/Captures/Recording-$(date +%Y-%m-%d_%H-%M-%S-%3N).mp4
    ${pkgs.wf-recorder}/bin/wf-recorder -f "$f"
  '';

  record-region-pkg = pkgs.writeShellScriptBin "niri-record-region" ''
    mkdir -p ~/Videos/Captures
    f=~/Videos/Captures/Recording-$(date +%Y-%m-%d_%H-%M-%S-%3N).mp4
    ${pkgs.wf-recorder}/bin/wf-recorder -g "$(${pkgs.slurp}/bin/slurp)" -f "$f"
  '';

  record-stop-pkg = pkgs.writeShellScriptBin "niri-record-stop" ''
    ${pkgs.procps}/bin/pkill -INT wf-recorder
    ${pkgs.libnotify}/bin/notify-send --app-name=Screencapture "Recording stopped"
  '';
in
{
  "XF86AudioRaiseVolume" = {
    _attrs = {
      hotkey-overlay-title = "Raise Volume";
    };
    spawn = (
      noctalia-ipc [
        "volume"
        "increase"
      ]
    );
  };

  "XF86AudioLowerVolume" = {
    _attrs = {
      hotkey-overlay-title = "Lower Volume";
    };
    spawn = (
      noctalia-ipc [
        "volume"
        "decrease"
      ]
    );
  };

  "XF86AudioMute".spawn = (
    noctalia-ipc [
      "volume"
      "muteOutput"
    ]
  );
  "XF86AudioMicMute".spawn = (
    noctalia-ipc [
      "volume"
      "muteInput"
    ]
  );

  "Mod+TouchpadScrollDown".spawn = (
    noctalia-ipc [
      "volume"
      "increase"
    ]
  );
  "Mod+TouchpadScrollUp".spawn = (
    noctalia-ipc [
      "volume"
      "decrease"
    ]
  );

  "XF86MonBrightnessUp".spawn = (
    noctalia-ipc [
      "brightness"
      "increase"
    ]
  );
  "XF86MonBrightnessDown".spawn = (
    noctalia-ipc [
      "brightness"
      "decrease"
    ]
  );

  "Mod+Shift+TouchpadScrollDown".spawn = brightnessctl ++ [
    "set"
    "2%+"
  ];
  "Mod+Shift+TouchpadScrollUp".spawn = brightnessctl ++ [
    "set"
    "2%-"
  ];

  "XF86RFKill".spawn = (
    noctalia-ipc [
      "wifi"
      "disable"
    ]
  );
  "XF86Bluetooth".spawn = (
    noctalia-ipc [
      "bluetooth"
      "toggle"
    ]
  );

  "XF86Tools".spawn = (
    noctalia-ipc [
      "settings"
      "toggle"
    ]
  );
  "Mod+I".spawn = (
    noctalia-ipc [
      "settings"
      "toggle"
    ]
  );

  # Applications
  "Mod+E".spawn = [ "nautilus" ];
  "Mod+Q".spawn = [ "kitty" ];
  "Mod+Shift+F".spawn = [ "firefox" ];
  "Mod+Shift+D".spawn = [ "zen-twilight" ];
  "Mod+Shift+C".spawn = [ "code" ];

  # UI Components
  "Mod+F1".spawn = (
    noctalia-ipc [
      "plugin:keybind-cheatsheet"
      "toggle"
    ]
  );
  "Mod+D".spawn = (
    noctalia-ipc [
      "launcher"
      "toggle"
    ]
  );
  "Mod+R".spawn = (
    noctalia-ipc [
      "launcher"
      "command"
    ]
  );
  "Mod+Shift+E".spawn = (
    noctalia-ipc [
      "launcher"
      "emoji"
    ]
  );
  "Mod+Shift+V".spawn = (
    noctalia-ipc [
      "launcher"
      "clipboard"
    ]
  );
  "Mod+X".spawn = (
    noctalia-ipc [
      "controlCenter"
      "toggle"
    ]
  );
  "Mod+P".spawn = (
    noctalia-ipc [
      "sessionMenu"
      "toggle"
    ]
  );

  "Mod+L".spawn = [ "hyprlock" ];

  # Resolution & Screenshots (Variables now defined as lists)
  "Mod+Shift+L".spawn = [ "${low-res-pkg}/bin/niri-low-res" ];
  "Mod+Shift+H".spawn = [ "${high-res-pkg}/bin/niri-high-res" ];

  "Print".spawn = [ "${screenshot-full-pkg}/bin/niri-screenshot-full" ];
  "Mod+Print".spawn = [ "${screenshot-region-pkg}/bin/niri-screenshot-region" ];

  "Mod+F2".spawn = [ "${record-full-pkg}/bin/niri-record-full" ];
  "Mod+F3".spawn = [ "${record-region-pkg}/bin/niri-record-region" ];
  "Mod+F4".spawn = [ "${record-stop-pkg}/bin/niri-record-stop" ];

  # Window Management (Non-spawn binds)
  "Mod+C".close-window = null;
  "Mod+H".maximize-column = null;
  "Mod+S".toggle-overview = null;
  "Mod+Left".focus-column-or-monitor-left = null;
  "Mod+Right".focus-column-or-monitor-right = null;
  "Mod+Up".focus-window-or-workspace-up = null;
  "Mod+Down".focus-window-or-workspace-down = null;
  "Mod+V".toggle-window-floating = null;
  "Mod+F".fullscreen-window = null;
  # "Mod+Shift+M".quit = "skip-confirmation";
  "Mod+W".toggle-column-tabbed-display = null;
}
// builtins.foldl' (acc: elem: acc // elem) { } (
  map (i: {
    "Mod+${builtins.toString i}".focus-workspace = i;
    "Mod+Shift+${builtins.toString i}".move-column-to-workspace = i;
  }) (lib.genList (x: x) 10)
)
