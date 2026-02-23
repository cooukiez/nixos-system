/*
  modules/home/desktop/nn/niri/idle-config.nix

  created by ludw
  on 2026-02-21
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
}
