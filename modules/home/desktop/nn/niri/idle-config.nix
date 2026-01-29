/*
  modules/home/desktop/nn/niri/idle-config.nix

  created by ludw
  on 2026-01-29
*/

{
  /*
    services.swayidle =
      let
        # lock command
        lockAndSuspend = "noctalia-shell ipc call lockScreen lockAndSuspend";
      in
      {
        enable = true;
        timeouts = [
          {
            # send notification 30 minutes before the lock
            timeout = 30 * 60; # 30 minutes
            command = "${pkgs.libnotify}/bin/notify-send 'Locking and suspending in 30 seconds' -t 5000";
          }
          {
            # wait another 30 seconds, then lock and suspend
            timeout = 30 * 60 + 30; # 30 minutes + 30 seconds
            command = lockAndSuspend;
          }
        ];

        # optional: make sure events behave consistently
        events = [
          {
            event = "before-sleep";
            command = lockAndSuspend;
          }
          {
            event = "after-resume";
            command = ""; # "${pkgs.sway}/bin/swaymsg 'output * power on'";
          }
          {
            event = "lock";
            command = lockAndSuspend;
          }
          {
            event = "unlock";
            command = ""; # "${pkgs.sway}/bin/swaymsg 'output * power on'";
          }
        ];
      };
  */
}
