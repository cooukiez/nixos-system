/*
  modules/home/desktop/nn/default.nix

  created by ludw
  on 2026-02-26
*/

{
  pkgs,
  lib,
  ...
}:
let
  formattedWeather = pkgs.writeShellScript "formatted-weather" (
    builtins.readFile ./scripts/formatted-weather.sh
  );
in
{
  imports = [
    ./noctalia

    ./packages.nix
    ./style.nix
    ./xdg-config.nix
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
  };

  services.gnome-keyring = {
    enable = true;
    components = [
      "pkcs11"
      "secrets"
      "ssh"
    ];
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = lib.mkForce "prefer-dark";
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = lib.mkForce ":";
    };
    "com/github/stunkymonkey/nautilus-open-any-terminal" = {
      terminal = "kitty";
    };
  };

  # touchscreen gestures
  systemd.user.services.lisgd = {
    Unit = {
      Description = "lisgd Touchscreen Gestures for niri";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart =
        let
          device = "/dev/input/by-path/pci-0000:00:15.1-platform-i2c_designware.1-event";
          gestures = [
            "-g '1,RL,R,*,R,niri msg action focus-column-right'"
            "-g '1,LR,L,*,R,niri msg action focus-column-left'"
            "-g '1,DU,B,*,R,niri msg action open-overview'"

            "-g '3,LR,*,*,R,niri msg action focus-column-left'"
            "-g '3,RL,*,*,R,niri msg action focus-column-right'"
            "-g '3,UD,*,*,R,niri msg action focus-workspace-up'"
            "-g '3,DU,*,*,R,niri msg action focus-workspace-down'"
          ];
        in
        "${pkgs.lisgd}/bin/lisgd -d ${device} -t 10 -T 5 ${builtins.concatStringsSep " " gestures}";

      Restart = "on-failure";
      RestartSec = "5s";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # disable niri polkit agent
  systemd.user.services."niri-flake-polkit" = {
    Unit = {
      Description = "Disabled Niri Polkit Agent (replaced by Noctalia)";
    };
    Install = {
      WantedBy = lib.mkForce [ ];
    };
    Service = {
      ExecStart = lib.mkForce "${pkgs.coreutils}/bin/true";
    };
  };
}
