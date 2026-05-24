/*
hosts/lvl/host.nix

part of nixos system
created 2026-04-22 by ludw
*/
{
  hostname = "lvl";
  hostSystem = "x86_64-linux";
  staticIP = "192.168.178.67";

  users = ["ludw"];

  primaryMonitor = "eDP-1";
  displayScale = 2;

  outputs = [
    {
      name = "eDP-1";
      mode = "3840x2400@60.000";
      scale = 2.0;
    }
    {
      name = "HDMI-A-1";
      mode = "1920x1080@60.000";
      x = 1920;
      y = 0;
    }
  ];
}
