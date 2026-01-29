/*
  modules/nixos/desktop/default.nix

  created by ludw
  on 2026-01-29
*/

{ inputs, pkgs, ... }:
{
  # enable sddm
  services.displayManager.sddm = {
    enable = true;
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

  # noctalia calendar support
  services.gnome.evolution-data-server.enable = true;

  environment.systemPackages = with pkgs; [
    # kde package for configuration of sddm
    kdePackages.sddm-kcm

    # deprecated
    /*
      (pkgs.runCommand "lvl-sddm-theme" { } ''
        mkdir -p $out/share/sddm/themes
        cp -r ${./lvl-sddm-theme} $out/share/sddm/themes/lvl-sddm-theme
      '')
    */

    # new sddm theme
    sddm-astronaut

    # noctalia packages
    (inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
      calendarSupport = true;
    })
  ];

  # enable hyprland
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
    package = pkgs.niri-unstable;
  };

  # disable some kde services
  systemd.user.services = {
    "app-org.kde.discover.notifier@autostart".enable = false;
    "app-org.kde.kalendarac@autostart".enable = false;
  };
}
