/*
modules/system/graphical/web/packages.nix

part of nixos system
created 2026-04-22 by ludw
*/
{pkgs, ...}: {
  browser = with pkgs; [
    tor-browser
  ];

  messenger = with pkgs; [
    beeper
    discord
    legcord
    signal-desktop
    slack
    slack-cli
    telegram-desktop
  ];

  download = with pkgs; [
    nicotine-plus

    qbittorrent-enhanced
    qbittorrent-cli
  ];
}
