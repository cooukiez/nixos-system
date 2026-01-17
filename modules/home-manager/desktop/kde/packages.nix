{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # core kde applications
    kdePackages.plasma-workspace
    kdePackages.kate
    kdePackages.dolphin
    kdePackages.konsole
    kdePackages.systemsettings
    kdePackages.okular
    kdePackages.gwenview
    kdePackages.ark
    kdePackages.spectacle
    kdePackages.plasma-systemmonitor

    # kde utilities
    kdePackages.discover
    kdePackages.kcalc
    kdePackages.kcharselect
    kdePackages.kclock
    kdePackages.kcolorchooser
    kdePackages.kolourpaint
    kdePackages.ksystemlog
    kdePackages.isoimagewriter
    kdePackages.partitionmanager

    # multimedia and pim
    kdePackages.elisa
    kdePackages.kdepim-runtime

    # games
    kdePackages.kmahjongg
    kdePackages.kmines
    kdePackages.kpat
    kdePackages.ksudoku

    # network and tools
    kdePackages.konversation
    kdePackages.ktorrent

    # theming and integration
    kdePackages.kiconthemes
    kdePackages.kcmutils
    kdePackages.qtstyleplugin-kvantum

    # system tools
    kdePackages.systemsettings
    kdePackages.drkonqi
    kdePackages.khelpcenter
    kdePackages.kcrash

    # non-kde helpers
    kdotool
    kdiff3

    # appearance themes / icons
    #     papirus-icon-theme
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
