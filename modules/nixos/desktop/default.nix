{ inputs, pkgs, ... }:
{
  # enable sddm
  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    wayland.enable = true;
  };

  # enable plasma, adds desktop entries to sddm
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
    # noctalia packages
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # enable hyprland
  programs.hyprland = {
    # install the packages from nixpkgs
    enable = true;
    # enable xwayland
    xwayland.enable = true;
  };

  # enable screen recorder for noctalia
  programs.gpu-screen-recorder.enable = true;

  # disable some kde services
  systemd.user.services = {
    "app-org.kde.discover.notifier@autostart".enable = false;
    # "app-org.kde.kalendarac@autostart".enable = false;
  };
}
