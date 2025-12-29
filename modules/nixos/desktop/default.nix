{ pkgs, ... }:
let
  kdeApps = pkgs.kdeApplications;
in
{
  # enable sddm
  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    wayland.enable = true;
  };
  
  # enable plasma
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
    kdeApps.discover
    kdeApps.kcalc
    kdeApps.kcharselect
    kdeApps.kclock
    kdeApps.kcolorchooser
    kdeApps.kolourpaint
    kdeApps.ksystemlog
    kdeApps.sddm-kcm
    kdeApps.isoimagewriter
    kdeApps.partitionmanager
    kdeApps.elisa
    kdeApps.kdepim-runtime
    kdeApps.kmahjongg
    kdeApps.kmines
    kdeApps.konversation
    kdeApps.kpat
    kdeApps.ksudoku
    kdeApps.ktorrent
  ];

  # disable some kde services
  systemd.user.services = {
    "app-org.kde.discover.notifier@autostart".enable = false;
    # "app-org.kde.kalendarac@autostart".enable = false;
  };
}