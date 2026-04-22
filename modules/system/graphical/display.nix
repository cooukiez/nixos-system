{
  pkgs,
  lib,
  ...
}:
let
  cfg = config.graphicalConfig.display;
in
{
  options.graphicalConfig = {
    display = lib.mkOption {
      type = lib.types.submodule {
        options = {
          wayland = lib.mkOption {
            type = lib.types.bool;
            default = true;
          };

          x11 = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
        };
      };

      default = { };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.wayland {
      programs.xwayland.enable = true;

      environment.systemPackages = with pkgs; [
        wayland-utils
        wlinhibit
        cliphist
        grim
        slurp
        wf-recorder
        wl-clipboard
      ];
    })

    (lib.mkIf cfg.x11 {
      services.xserver = {
        enable = true;
        xkb = {
          layout = "de";
          options = "eurosign:e,caps:escape";
          variant = "";
        };
        excludePackages = with pkgs; [ xterm ];
      };

      environment.systemPackages = with pkgs; [
        wmctrl
        xdotool
        xmodmap
        xclip
        xsel
      ];
    })
  ];
}
