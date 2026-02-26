/*
  modules/nixos/desktop/default.nix

  created by ludw
  on 2026-02-23
*/

{
  inputs,
  hostSystem,
  pkgs,
  ...
}:
let
  autoSessionScript = pkgs.writeShellApplication {
    name = "auto-session-selector";
    text = ''
      case "$USER" in
        ceirs)
          exec niri-session
          ;;
        ludw)
          exec ${pkgs.kdePackages.plasma-workspace}/libexec/plasma-dbus-run-session-if-needed \
               ${pkgs.kdePackages.plasma-workspace}/bin/startplasma-wayland
          ;;
        redi)
          exec niri-session
          ;;
        *)
          echo "no session configured for user $USER."
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
in
{
  # enable sddm
  services.displayManager.sddm = {
    enable = true;
    # required for 4k displays
    enableHidpi = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
  };

  # set default session to auto-selection
  services.displayManager.sessionPackages = [ autoSessionDesktop ];
  services.displayManager.defaultSession = "auto-selection";

  # enable plasma, adds desktop entries to sddm
  services.desktopManager.plasma6 = {
    enable = true;
  };

  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.polkit-kde-agent-1
  ];

  environment.systemPackages = with pkgs; [
    # sddm theme
    sddm-astronaut
  ];

  # currently no using hyprland
  /*
    programs.hyprland = {
      # install the packages from nixpkgs
      enable = true;
      # enable xwayland
      xwayland.enable = true;
    };
  */

  niri-flake.cache.enable = true;
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  # disable kde services
  systemd.user.services = {
    "app-org.kde.discover.notifier@autostart".enable = false;
    "app-org.kde.kalendarac@autostart".enable = false;
  };
}
