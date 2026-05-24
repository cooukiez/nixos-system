/*
modules/system/graphical/desktop/niri/default.nix

part of nixos system
created 2026-04-22 by ludw
*/
{
  inputs,
  config,
  pkgs,
  lib,
  hostConfig,
}:
(import ./wrappers/niri.nix {inherit inputs config lib;}).apply {
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
        tap = {};

        accel-speed = 0.25;
        scroll-factor = 1.5;

        natural-scroll = {};
        disabled-on-external-mouse = {};
      };

      mouse = {
        accel-speed = 0.1;
        # natural-scroll = { };
      };

      trackpoint = {
        accel-speed = 1.0;
        # natural-scroll = { };
      };

      focus-follows-mouse = {
        _props = {
          max-scroll-amount = "25%";
        };
      };

      warp-mouse-to-focus = {};

      mod-key = "Super";
      mod-key-nested = "Alt";
    };

    binds = import ./binds.nix {inherit config pkgs lib;};

    environment = {
      ELM_DISPLAY = "wl";
      CLUTTER_BACKEND = "wayland";

      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      NIXOS_OZONE_WL = "1";

      # scaling
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_ENABLE_HIGHDPI_SCALING = "1";
      QT_SCALE_FACTOR_ROUNDING_POLICY = "PassThrough";

      # smoother scrolling
      MOZ_USE_XINPUT2 = "1";
    };

    overview = {
      workspace-shadow.off = {};
    };

    layout = {
      gaps = 5;
      border.off = {};

      struts = {
        left = 10;
        right = 10;
        top = 10;
        bottom = 10;
      };

      default-column-width.proportion = 0.5;

      preset-column-widths._children = [
        {proportion = 1.0 / 3.0;}
        {proportion = 0.5;}
        {proportion = 2.0 / 3.0;}
      ];

      preset-window-heights._children = [
        {proportion = 1.0 / 3.0;}
        {proportion = 0.5;}
        {proportion = 2.0 / 3.0;}
        {proportion = 1.0;}
      ];

      focus-ring = {
        off = {};
      };

      shadow = {
        on = {};
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
        on = {};

        place-within-column = {};
        position = "top";

        width = 8;
        corner-radius = 8;
        gap = 8;
        gaps-between-tabs = 8;

        active-color = "rgba(224, 224, 224, 100%)";
        inactive-color = "rgba(224, 224, 224, 30%)";
      };
    };

    _children =
      # outputs
      builtins.map (out: {
        output = {
          _args = [out.name];
          mode = out.mode;
          scale = out.scale or 1.0;
          position = {
            _props.x = out.x or 0;
            _props.y = out.y or 0;
          };
        };
      })
      hostConfig.outputs
      ++ [
        # layer rules
        {
          layer-rule = {
            _children = [{match._props.namespace = "^noctalia-overview*";}];
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
            _children = [{match._props.app-id = "kitty";}];
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
        "${lib.getExe config.pkgConfig.hyprlock}; sleep 3; systemctl suspend"
      ];
    };

    hotkey-overlay.skip-at-startup = true;
    screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d-%H%M%S.png";
  };
}
