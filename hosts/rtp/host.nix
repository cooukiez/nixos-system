/*
hosts/rtp/host.nix

part of nixos system
created 2026-05-15 by ludw
*/
{
  hostname = "rtp";
  hostSystem = "x86_64-linux";
  staticIP = "192.168.178.170";

  users = ["redi"];

  primaryMonitor = "eDP-1";
  displayScale = 1;

  outputs = [
    {
      name = "eDP-1";
      mode = "1920x1080@60.000";
    }
    {
      name = "HDMI-A-1";
      mode = "1920x1080@60.000";
      x = 1920;
      y = 0;
    }
  ];
}
