{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./niri.nix
    ./packages.nix
    ./style.nix
  ];

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
  };

  systemd.user.services.noctalia = {
    Unit = {
      Description = "Noctalia Shell";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.quickshell}/bin/qs -c noctalia-shell";
      Restart = "on-failure";
      RestartSec = 1;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
