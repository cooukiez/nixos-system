/*
  modules/home/desktop/kde/packages.nix

  created by ludw
  on 2026-02-21
*/

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
    kdePackages.sweeper

    # multimedia and pim
    kdePackages.elisa
    kdePackages.kdepim-runtime
    kdePackages.koko

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

    # krunner plugins
    jetbrains-runner

    # programs
    gImageReader-qt
    libreoffice-qt-fresh
    strawberry
  ];
}
