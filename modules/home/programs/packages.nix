/*
modules/home/programs/packages.nix

part of nixos system
created 2026-04-27 by ludw
*/
{pkgs, ...}: {
  #
  # desktop specific
  #
  nn = with pkgs; [
    euphonica
    exhibit
    eyedropper
    gImageReader
    gapless
    impression
    inspector
    iplookup-gtk
    keypunch
    libreoffice-fresh
    metadata-cleaner
    mission-center
    nucleus
    pdfarranger
    qalculate-gtk
    quick-lookup
    system-config-printer
  ];

  gnome = with pkgs; [
    gnome-calculator
    gnome-calendar
    gnome-clocks
    gnome-contacts
    gnome-font-viewer
    gnome-frog
    gnome-graphs
    gnome-maps
    gnome-menus
    gnome-notes
    gnome-obfuscate
    gnome-photos
    gnome-text-editor
    gnome-weather

    baobab
    decibels
    errands
    loupe
    seahorse
    showtime
    snapshot

    (pkgs.symlinkJoin {
      name = "gnome-control-center-wrapped";
      paths = [pkgs.gnome-control-center];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/gnome-control-center \
          --set XDG_CURRENT_DESKTOP "GNOME"
      '';
    })
  ];

  kde = with pkgs; [
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

    gImageReader-qt
    libreoffice-qt-fresh
    qalculate-qt
    strawberry
  ];
}
