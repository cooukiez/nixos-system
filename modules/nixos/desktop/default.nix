/*
  modules/nixos/desktop/default.nix

  created by ludw
  on 2026-01-25
*/

{
  inputs,
  hostSystem,
  pkgs,
  ...
}:
{
  # enable sddm
  services.displayManager.sddm = {
    enable = true;
    # required for 4k displays
    enableHidpi = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
  };

  # enable plasma, adds desktop entries to sddm
  services.desktopManager.plasma6 = {
    enable = true;
  };

  # exclude packages so they are not installed system-wide
  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.kate
    kdePackages.dolphin
    kdePackages.konsole
    kdePackages.okular
    kdePackages.gwenview
    kdePackages.ark
    kdePackages.spectacle
    kdePackages.discover
    kdePackages.elisa
    kdePackages.khelpcenter
  ];

  environment.systemPackages = with pkgs; [
    # sddm theme
    sddm-astronaut
    # noctalia packages
    (inputs.noctalia.packages.${hostSystem}.default.override {
      calendarSupport = true;
    })
  ];

  # currently no using hyprland
  /*
    programs.hyprland = {
      # install the packages from nixpkgs
      enable = true;
      # enable xwayland
      xwayland.enable = true;
    };
  */

  niri-flake.cache.enable = true;
  programs.niri = {
    enable = true;
    # flake should ideally follow nixpkgs-unstable as well
    package = pkgs.niri-unstable;
  };

  # disable kde services
  systemd.user.services = {
    "app-org.kde.discover.notifier@autostart".enable = false;
    "app-org.kde.kalendarac@autostart".enable = false;
  };
}
