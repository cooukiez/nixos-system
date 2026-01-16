{ pkgs, ... }:
{
  xdg.configFile."libinput-gestures/libinput-gestures.conf".text = ''
    # three finger gestures

    gesture swipe left 3 xdotool key Meta+Right
    gesture swipe right 3 xdotool key Meta+Left
    gesture swipe up 3 xdotool key Meta+G
    gesture swipe down 3 xdotool key Meta+W
  '';

  systemd.user.services.libinput-gestures = {
    Unit = {
      Description = "libinput gestures";
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
