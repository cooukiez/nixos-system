{
  inputs,
  pkgs,
  hostSystem,
  ...
}:
let
  autoSessionScript = pkgs.writeShellApplication {
    name = "auto-session-selector";
    text = ''
      case "$USER" in
        ceirs|redi)
          exec ${pkgs.niri-unstable}/bin/niri-session
          ;;
        ludw)
          exec ${pkgs.kdePackages.plasma-workspace}/libexec/plasma-dbus-run-session-if-needed \
               ${pkgs.kdePackages.plasma-workspace}/bin/startplasma-wayland
          ;;
        *)
          echo "No session configured for user $USER." >&2
          exit 1
          ;;
      esac
    '';
  };

  autoSessionDesktop =
    (pkgs.writeTextDir "share/wayland-sessions/auto-selection.desktop" ''
      [Desktop Entry]
      Name=Automatic Session
      Comment=User-specific session auto-detect
      Exec=${autoSessionScript}/bin/auto-session-selector
      Type=Application
    '').overrideAttrs
      (_: {
        passthru.providedSessions = [ "auto-selection" ];
      });

  mkEnableDefault = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
in
{
  options.graphicalConfig = {
    session = lib.mkOption {
      type = lib.types.submodule {
        options = {
          niri = mkEnableDefault;

          kde = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
        };
      };

      default = { };
    };
  };

  config = lib.mkMerge [
    {
      services.displayManager.sddm = {
        enable = true;
        enableHidpi = true;
        wayland.enable = true;
        theme = "sddm-astronaut-theme";
      };

      services.displayManager.sessionPackages = [ autoSessionDesktop ];
      services.displayManager.defaultSession = "auto-selection";

      environment.systemPackages = with pkgs; [
        sddm-astronaut
      ];
    }

    (lib.mkIf cfg.niri {
      niri-flake.cache.enable = true;
      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };
    })

    (lib.mkIf cfg.kde {
      services.desktopManager.plasma6.enable = true;

      environment.plasma6.excludePackages = with pkgs; [
        kdePackages.polkit-kde-agent-1
      ];

      systemd.user.services = {
        "app-org.kde.discover.notifier@autostart".enable = false;
        "app-org.kde.kalendarac@autostart".enable = false;
      };
    })
  ];
}
