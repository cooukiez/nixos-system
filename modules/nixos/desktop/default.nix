{ pkgs, ... }:
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
    # packages for kde
    kdePackages.discover
    kdePackages.kcalc
    kdePackages.kcharselect
    kdePackages.kclock
    kdePackages.kcolorchooser
    kdePackages.kolourpaint
    kdePackages.ksystemlog
    kdePackages.sddm-kcm
    kdePackages.isoimagewriter
    kdePackages.partitionmanager
    kdePackages.elisa
    kdePackages.kdepim-runtime
    kdePackages.kmahjongg
    kdePackages.kmines
    kdePackages.konversation
    kdePackages.kpat
    kdePackages.ksudoku
    kdePackages.ktorrent
    kdePackages.koi
    kdePackages.kiconthemes
    kdePackages.qtstyleplugin-kvantum
    #kdePackages.ksshaskpass

    kdotool
    kdiff3

    # noctalia packages
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # disable some kde services
  systemd.user.services = {
    "app-org.kde.discover.notifier@autostart".enable = false;
    # "app-org.kde.kalendarac@autostart".enable = false;
  };
}
