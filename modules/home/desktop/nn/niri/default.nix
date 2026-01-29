/*
  modules/home-manager/desktop/noctalia/niri.nix

  created by ludw
  on 2026-01-29
*/

{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./idle-config.nix
  ];

  programs.niri.settings = {
    prefer-no-csd = true;
    hotkey-overlay.skip-at-startup = true;

    screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d-%H%M%S.png";

    xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

    binds = import ./binds.nix { inherit lib; };

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
  };
}
