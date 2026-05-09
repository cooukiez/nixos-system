/*
  modules/system/graphical/web/packages.nix

  created by ludw
  on 2026-04-22
*/

{
  pkgs,
  ...
}:
{
  messenger = with pkgs; [
    signal-desktop
    unstable.discord
    unstable.legcord
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
