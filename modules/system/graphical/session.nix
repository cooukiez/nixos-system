{
  inputs,
  config,
  pkgs,
  lib,
  userList,
  ...
}:
let
  cfg = config.graphicalConfig.session;

  niri = (
    import ./desktop/niri.nix {
      inherit
        inputs
        config
        pkgs
        ;
    }
  );

  sessionCommands = {
    niri = "exec ${niri.wrapper}/bin/niri-session";
    kde = "exec ${pkgs.kdePackages.plasma-workspace}/libexec/plasma-dbus-run-session-if-needed ${pkgs.kdePackages.plasma-workspace}/bin/startplasma-wayland";
    none = "exit 0";
  };

  caseBranches = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (name: config: ''
      ${name})
        ${sessionCommands.${config.session}}
        ;;
    '') userList
  );

  autoSessionScript = pkgs.writeShellApplication {
    name = "auto-session-selector";
    text = ''
      case "$USER" in
        ${caseBranches}
        *) exit 1 ;;
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
in
{
  imports = [
    inputs.niri.nixosModules.niri
  ];

  options.graphicalConfig = {
    session = lib.mkOption {
      type = lib.types.submodule {
        options = {
          niri = lib.mkOption {
            type = lib.types.bool;
            default = true;
          };

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
      nixpkgs.overlays = [ inputs.niri.overlays.niri ];

      graphicalConfig.display.wayland = lib.mkForce true;

      niri-flake.cache.enable = true;
      programs.niri = {
        enable = true;
        package = niri.wrapper;
      };
    })

    (lib.mkIf cfg.kde {
      graphicalConfig.display.x11 = lib.mkForce true;

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
