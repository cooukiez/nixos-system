{
  pkgs,
  ...
}:
{
  messenger = with pkgs; [
    signal-desktop
    unstable.discord
    unstable.legcord
    element-desktop
    # cinny-desktop
  ];

  download = with pkgs; [
    # qbittorrent-enhanced
    # qbittorrent-cli
  ];
}
