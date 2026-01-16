{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # packages for kde
    kdePackages.discover
    kdePackages.kcalc
    kdePackages.kcharselect
    kdePackages.kclock
    kdePackages.kcolorchooser
    kdePackages.kolourpaint
    kdePackages.ksystemlog
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
    kdePackages.kiconthemes
    kdePackages.qtstyleplugin-kvantum
    kdePackages.kcmutils
    #kdePackages.ksshaskpass

    kdotool
    kdiff3

    # appearance themes / icons
    papirus-icon-theme
    #     tela-icon-theme
    #     tela-circle-icon-theme
    #     tango-icon-theme
    #     fluent-icon-theme
    #     reversal-icon-theme
    #     qogir-icon-theme
    #     numix-icon-theme
    #     numix-icon-theme-circle
    #     numix-icon-theme-square
    #     whitesur-icon-theme
    #     whitesur-cursors
    #     adwaita-icon-theme-legacy
    #     breeze-chameleon-icons
  ];
}
