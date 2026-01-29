/*
  modules/home-manager/desktop/noctalia/niri.nix

  created by ludw
  on 2026-01-29
*/

{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.niri.settings = {
    prefer-no-csd = true;
    hotkey-overlay.skip-at-startup = true;
    screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d-%H%M%S.png";
    xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

    input = {
      keyboard = {
        xkb = {
          layout = "de";
        };
      };

      touchpad = {
        enable = true;
        tap = true;

        accel-speed = 0.25;
        scroll-factor = 1.5;
        natural-scroll = true;
      };

      mouse = {
        enable = true;
        accel-speed = 0.5;
        natural-scroll = false;
      };

      trackpoint = {
        enable = true;
        accel-speed = 1.0;
        natural-scroll = false;
      };

      focus-follows-mouse = {
        enable = true;
        max-scroll-amount = "25%";
      };

      power-key-handling.enable = true;
      warp-mouse-to-focus.enable = true;

      mod-key = "Super";
      mod-key-nested = "Alt";
    };

    outputs.eDP-1 = {
      enable = true;
      mode = {
        width = 1920;
        height = 1080;
        refresh = 60.000;
      };
      scale = 2.0;
    };

    switch-events = {
      lid-close.action.spawn = [
        "noctalia-shell"
        "ipc"
        "call"
        "lockScreen"
        "lock"
      ];
      # lid-open.action.spawn = ["notify-send" "welcome back"];
    };

    overview = {
      workspace-shadow = {
        enable = false;
      };
    };

    layout = {
      gaps = 5;
      struts = {
        left = 10;
        right = 10;
        top = 10;
        bottom = 10;
      };

      border.enable = false;

      default-column-width.proportion = 0.5;

      preset-column-widths = [
        { proportion = 1.0 / 3.0; }
        { proportion = 0.5; }
        { proportion = 2.0 / 3.0; }
      ];

      preset-window-heights = [
        { proportion = 1.0 / 3.0; }
        { proportion = 0.5; }
        { proportion = 2.0 / 3.0; }
        { proportion = 1.0; }
      ];

      focus-ring = {
        enable = false;
      };

      shadow = {
        enable = true;
        draw-behind-window = true;
        softness = 30;
        spread = 5;
        offset.x = 0;
        offset.y = 5;
        color = "#00000070";
      };

      tab-indicator = {
        enable = true;
        place-within-column = true;
        position = "top";

        width = 8;
        corner-radius = 8;
        gap = 8;
        gaps-between-tabs = 8;

        active = {
          color = "rgba(224, 224, 224, 100%)";
        };

        inactive = {
          color = "rgba(224, 224, 224, 30%)";
        };

        length.total-proportion = 1.0;
      };

    };

    layer-rules = [
      {
        matches = [
          {
            namespace = "^noctalia-overview*";
          }
        ];

        place-within-backdrop = true;
      }
    ];

    window-rules = [
      {
        geometry-corner-radius =
          let
            radius = 10.0;
          in
          {
            bottom-left = radius;
            bottom-right = radius;
            top-left = radius;
            top-right = radius;
          };

        clip-to-geometry = true;
        draw-border-with-background = false;
        open-maximized = true;
        open-fullscreen = false;
      }
      {
        matches = [
          {
            app-id = "kitty";
          }
          {
            app-id = "thunar";
          }
        ];

        open-maximized = false;
      }
    ];

    binds =
      with config.lib.niri.actions;
      let
        wpctl = spawn "wpctl";
        brightnessctl = spawn "brightnessctl";
        noctalia-ipc = spawn "noctalia-shell" "ipc" "call";
        capture-script = spawn "/etc/nixos/modules/home-manager/desktop/noctalia/capture.sh";
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

        "Print".action = capture-script "0";
        "Mod+Print".action = capture-script "1";

        "Mod+F2".action = capture-script "2";
        "Mod+F3".action = capture-script "3";
        "Mod+F4".action = capture-script "stop";

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
      };
  };
}
