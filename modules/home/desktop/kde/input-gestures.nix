/*
  modules/home/desktop/kde/input-gestures.nix

  created by ludw
  on 2026-02-26
*/

{
  pkgs,
  lib,
  ...
}:
{
  # three finger gestures for workspace switching
  xdg.configFile."libinput-gestures.conf".text = ''
    # three finger gestures
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
      ExecStart = "${libpkgs.libinput-gestures}/bin/libinput-gestures";
      Environment = "DISPLAY=:0";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

}
