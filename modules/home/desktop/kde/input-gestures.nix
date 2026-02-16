/*
  modules/home/desktop/kde/input-gestures.nix

  created by ludw
  on 2026-02-14
*/

{
  pkgs,
  ...
}:
{
  # enable three finger gestures for workspace switching
  xdg.configFile."libinput-gestures.conf".text = ''
    # three finger gestures
    gesture swipe left 3 xdotool key Super+Right
    gesture swipe right 3 xdotool key Super+Left
    gesture swipe up 3 xdotool key Super+G
    gesture swipe down 3 xdotool key Super+W
  '';

  systemd.user.services.libinput-gestures = {
    Unit = {
      Description = "libinput gestures";
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures";
      Environment = "DISPLAY=:0";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

}
