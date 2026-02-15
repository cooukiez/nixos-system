{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # programs
    heroic
    mangohud

    (prismlauncher.override {
      additionalPrograms = [ ffmpeg ];

      jdks = [

      ];
    })

    # compatibilty
    bottles
    lutris
    protonup-ng

  ];

  # steam
  programs.steam = {
    enable = true;

    # remotePlay.openFirewall = true;
    # dedicatedServer.openFirewall = true;
    # localNetworkGameTransfers.openFirewall = true;
  };

  # gamescope
  programs.gamescope = {
    enable = false;
    capSysNice = true;
  };
}
