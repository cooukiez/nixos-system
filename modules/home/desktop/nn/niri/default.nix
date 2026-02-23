/*
  modules/home/desktop/nn/niri/default.nix

  created by ludw
  on 2026-02-21
*/

{
  config,
  pkgs,
  lib,
  ...
}:
let
  # Define the custom McMojave cursor package
  mcmojave-cursor-theme = pkgs.stdenv.mkDerivation {
    pname = "mcmojave-cursors";
    version = "master";

    src = pkgs.fetchFromGitHub {
      owner = "vinceliuice";
      repo = "McMojave-cursors";
      rev = "master";
      # Ensure this matches your nix-prefetch-git output
      sha256 = "sha256-4YqSucpxA7jsuJ9aADjJfKRPgPR89oq2l0T1N28+GV0=";
    };

    # We skip the install.sh script because it tries to write to $HOME.
    # Instead, we manually copy the 'dist' folder to the Nix store output.
    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/icons/McMojave-cursors
      cp -pr dist/* $out/share/icons/McMojave-cursors/

      runHook postInstall
    '';
  };
in
{
  imports = [
    ./idle-config.nix
  ];

  home.packages = [
    mcmojave-cursor-theme
  ];

  programs.niri.settings = {
    prefer-no-csd = true;
    hotkey-overlay.skip-at-startup = true;

    screenshot-path = "${config.home.homeDirectory}/Pictures/Screenshots/%Y-%m-%d-%H%M%S.png";

    xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

    binds = import ./binds.nix { inherit config; };

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
        "sh"
        "-c"
        "niri msg action power-off-monitors && noctalia-shell ipc call lockScreen lock && systemctl suspend"
      ];

      lid-open.action.spawn = [
        "sh"
        "-c"
        "noctalia-shell ipc call lockScreen lock"
      ];
    };

    cursor = {
      theme = "McMojave-cursors";
      # size is set in env
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
