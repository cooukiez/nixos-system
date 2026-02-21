/*
  modules/home/desktop/nn/niri/idle-config.nix

  created by ludw
  on 2026-02-18
*/

{
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        ignore_dbus_inhibit = false;
        lock_cmd = "noctalia-shell ipc call sessionMenu lockAndSuspend";
      };

      listener = [
        # lock after 10 min
        {
          timeout = 10 * 60;
          on-timeout = "noctalia-shell ipc call sessionMenu lockAndSuspend";
        }

        # turn off screen after 5 min
        {
          timeout = 5 * 60;
          on-timeout = "niri msg action power-off-monitors";
          on-resume = "niri msg action power-on-monitors";
        }
      ];
    };
  };

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
