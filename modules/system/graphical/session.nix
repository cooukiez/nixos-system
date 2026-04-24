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

  sessionCommands = {
    niri = "exec ${config.pkgConfig.niri}/bin/niri-session";
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
    name = "auto-session";
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
      Exec=${autoSessionScript}/bin/auto-session
      Type=Application
    '').overrideAttrs
      (_: {
        passthru.providedSessions = [ "auto-selection" ];
      });
in
{
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

  options.pkgConfig = {
    niri = lib.mkOption { type = lib.types.package; };
    noctalia = lib.mkOption { type = lib.types.package; };
    hyprlock = lib.mkOption { type = lib.types.package; };
    hypridle = lib.mkOption { type = lib.types.package; };
  };

  config = lib.mkMerge [
    {
      services.displayManager.sddm = {
        enable = true;
        enableHidpi = true;
        wayland = {
          enable = true;
          compositor = "kwin";
        };

        theme = "sddm-astronaut-theme";

        extraPackages = with pkgs; [
          kdePackages.qtmultimedia
        ];
      };

      services.displayManager.sessionPackages = [ autoSessionDesktop ];
      services.displayManager.defaultSession = "auto-selection";

      security.pam.services.hyprlock = { };

      # disable fingerprint for boot login
      security.pam.services.login.fprintAuth = false;

      environment.systemPackages = with pkgs; [
        sddm-astronaut
      ];
    }

    (lib.mkIf cfg.niri (
      let
        load =
          path:
          import path {
            inherit
              inputs
              config
              pkgs
              lib
              ;
          };

        modules = {
          niri = load ./desktop/niri;
          hyprlock = load ./desktop/niri/hyprlock.nix;
          hypridle = load ./desktop/niri/hypridle.nix;
        };
      in
      {
        pkgConfig = (lib.mapAttrs (_: m: m.wrapper) modules) // {
          noctalia = pkgs.noctalia.override { calendarSupport = true; };
        };

        environment.systemPackages = [
          config.pkgConfig.hyprlock
        ];

        graphicalConfig.display.wayland = lib.mkForce true;

        security.pam.services.sddm.enableGnomeKeyring = true;
        services.gnome.gnome-keyring.enable = true;

        services.hypridle = {
          enable = true;
          package = config.pkgConfig.hypridle;
        };

        programs.niri = {
          enable = true;
          package = config.pkgConfig.niri;
        };

        xdg.portal = {
          xdgOpenUsePortal = true;
          extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
        };
      }
    ))

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
