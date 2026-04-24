{
  inputs,
  config,
  pkgs,
  lib,
}:
(import ./wrappers/niri.nix { inherit inputs config lib; }).apply {
  inherit pkgs;

  settings = {
    xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

    input = {
      keyboard = {
        xkb = {
          layout = "de";
        };
      };

      touchpad = {
        tap = { };

        accel-speed = 0.25;
        scroll-factor = 1.5;

        natural-scroll = { };
        disabled-on-external-mouse = { };
      };

      mouse = {
        accel-speed = 0.1;
        natural-scroll = { };
      };

      trackpoint = {
        accel-speed = 1.0;
        natural-scroll = { };
      };

      focus-follows-mouse = {
        _props = {
          max-scroll-amount = "25%";
        };
      };

      warp-mouse-to-focus = { };

      mod-key = "Super";
      mod-key-nested = "Alt";
    };

    binds = import ./binds.nix { inherit config pkgs lib; };

    overview = {
      workspace-shadow.off = { };
    };

    layout = {
      gaps = 5;
      border.off = { };

      struts = {
        left = 10;
        right = 10;
        top = 10;
        bottom = 10;
      };

      default-column-width.proportion = 0.5;

      preset-column-widths._children = [
        { proportion = 1.0 / 3.0; }
        { proportion = 0.5; }
        { proportion = 2.0 / 3.0; }
      ];

      preset-window-heights._children = [
        { proportion = 1.0 / 3.0; }
        { proportion = 0.5; }
        { proportion = 2.0 / 3.0; }
        { proportion = 1.0; }
      ];

      focus-ring = {
        off = { };
      };

      shadow = {
        on = { };
        draw-behind-window = true;

        softness = 30;
        spread = 5;
        offset = {
          _props.x = 0;
          _props.y = 5;
        };

        color = "#00000070";
      };

      tab-indicator = {
        on = { };

        place-within-column = { };
        position = "top";

        width = 8;
        corner-radius = 8;
        gap = 8;
        gaps-between-tabs = 8;

        active-color = "rgba(224, 224, 224, 100%)";
        inactive-color = "rgba(224, 224, 224, 30%)";
      };
    };

    _children = [
      # outputs
      {
        output = {
          _args = [ "eDP-1" ];
          mode = "3840x2400@60.000";
          scale = 2.0;
          position = {
            _props.x = 0;
            _props.y = 0;
          };
        };
      }
      {
        output = {
          _args = [ "HDMI-A-1" ];
          mode = "1920x1080@60.000";
          scale = 1.0;
          position = {
            _props.x = 1920;
            _props.y = 0;
          };
        };
      }

      # layer rules
      {
        layer-rule = {
          _children = [ { match._props.namespace = "^noctalia-overview*"; } ];
          place-within-backdrop = true;
        };
      }

      # window rules
      {
        window-rule = {
          geometry-corner-radius = 10.0;
          clip-to-geometry = true;

          draw-border-with-background = false;

          open-maximized = true;
          open-fullscreen = false;
        };
      }
      {
        window-rule = {
          _children = [ { match._props.app-id = "kitty"; } ];
          open-maximized = false;
        };
      }
    ];

    # disable window decorations
    prefer-no-csd = true;

    switch-events = {
      lid-close.spawn._args = [
        "sh"
        "-c"
        "${lib.getExe pkgs.hyprlock}; sleep 3; systemctl suspend"
      ];
    };

    hotkey-overlay.skip-at-startup = true;
    screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d-%H%M%S.png";
  };
}
