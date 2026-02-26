/*
  modules/home/desktop/kde/packages.nix

  created by ludw
  on 2026-02-23
*/

{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # kde utilities
    kdePackages.kcalc
    kdePackages.kcharselect
    kdePackages.kclock
    kdePackages.kcolorchooser
    kdePackages.kolourpaint
    kdePackages.ksystemlog
    kdePackages.isoimagewriter
    kdePackages.sweeper
    kdePackages.koko
    kdePackages.kmahjongg
    kdePackages.kmines
    kdePackages.kpat
    kdePackages.ksudoku
    kdePackages.konversation
    kdePackages.ktorrent
    kdePackages.qtstyleplugin-kvantum
    kdePackages.kcrash
    kdotool
    kdiff3
    jetbrains-runner

    # programs
    gImageReader-qt
    libreoffice-qt-fresh
    strawberry
  ];
}
