{
  inputs,
  config,
  pkgs,
  lib,
}:
inputs.wrappers.wrapperModules.niri.apply {
  inherit pkgs;

  settings = {
    prefer-no-csd = true;
    xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

    binds = import ./binds.nix { inherit config pkgs lib; };

    input = {
      keyboard = {
        xkb = {
          layout = "de";
        };
      };

      touchpad = {
        tap = null;

        accel-speed = 0.25;
        scroll-factor = 1.5;

        natural-scroll = null;
        disabled-on-external-mouse = null;
      };

      mouse = {
        accel-speed = 0.1;
        natural-scroll = null;
      };

      trackpoint = {
        accel-speed = 1.0;
        natural-scroll = null;
      };

      focus-follows-mouse = {
        _attrs = {
          max-scroll-amount = "25%";
        };
      };

      warp-mouse-to-focus = null;

      mod-key = "Super";
      mod-key-nested = "Alt";
    };

    outputs."eDP-1" = {
      mode = "3840x2400@60.000";
      scale = 2.0;
      position = {
        _attrs.x = 0;
        _attrs.y = 0;
      };
    };

    outputs."HDMI-A-1" = {
      mode = "1920x1080@60.000";
      scale = 1.0;
      position = {
        _attrs.x = 1920;
        _attrs.y = 0;
      };
    };

    switch-events = {
      lid-close.spawn = [
        "sh"
        "-c"
        "${lib.getExe pkgs.hyprlock}; sleep 3; systemctl suspend"
      ];
    };

    overview = {
      workspace-shadow.off = null;
    };

    layout = {
      gaps = 5;
      border.off = null;

      struts = {
        left = 10;
        right = 10;
        top = 10;
        bottom = 10;
      };

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
        off = null;
      };

      shadow = {
        on = null;
        draw-behind-window = true;

        softness = 30;
        spread = 5;
        offset = {
          _attrs.x = 0;
          _attrs.y = 5;
        };

        color = "#00000070";
      };

      tab-indicator = {
        on = null;

        place-within-column = null;
        position = "top";

        width = 8;
        corner-radius = 8;
        gap = 8;
        gaps-between-tabs = 8;

        active-color = "rgba(224, 224, 224, 100%)";
        inactive-color = "rgba(224, 224, 224, 30%)";
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
        geometry-corner-radius = 10.0;
        clip-to-geometry = true;

        draw-border-with-background = false;

        open-maximized = true;
        open-fullscreen = false;
      }
      {
        matches = [
          { app-id = "kitty"; }
        ];

        open-maximized = false;
      }
    ];

    hotkey-overlay.skip-at-startup = true;
    screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d-%H%M%S.png";
  };
}
