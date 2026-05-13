/*
  modules/home/desktop/kde/default.nix

  part of nixos system
  created 2026-02-26
*/

{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.desktop.kde;
in
{
  imports = [
    ./packages.nix
  ];

  config = lib.mkIf cfg {
    # three finger gestures
    xdg.configFile."libinput-gestures.conf".text = ''
      gesture swipe left 3 xdotool key Super+Right
      gesture swipe right 3 xdotool key Super+Left
      gesture swipe up 3 xdotool key Super+G
      gesture swipe down 3 xdotool key Super+W
    '';

    systemd.user.services.libinput-gestures = {
      Unit = {
        Description = "KDE libinput-Gestures";
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${lib.getExe pkgs.libinput-gestures}";
        Environment = "DISPLAY=:0";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    home.sessionVariables = {
      XCURSOR_SIZE = "24";

      # GIT_ASKPASS = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
      # SSH_ASKPASS = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";

      # remove decorations
      UBUNTU_MENUPROXY = 1;
    };
  };
}
