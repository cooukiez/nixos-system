/*
  modules/home/desktop/kde/packages.nix

  created by ludw
  on 2026-02-26
*/

{
  pkgs,
  ...
}:
let
  breezeChameleonDark = pkgs.fetchzip {
    url = "https://github.com/cooukiez/breeze-chameleon-dark-upstream/releases/download/latest/Breeze-Chameleon-Dark.tar.xz";
    sha256 = "sha256-18d1HcluLQbMcigaGn5tG01xzTug5sNyGZawot0zrG8=";
  };
in
{
  home.file.".local/share/icons/Breeze-Chameleon-Dark" = {
    source = breezeChameleonDark;
    recursive = true;
  };
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

    # new
    qalculate-qt
  ];
}
