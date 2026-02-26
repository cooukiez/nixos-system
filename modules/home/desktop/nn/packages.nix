/*
  modules/home/desktop/nn/packages.nix

  created by ludw
  on 2026-02-23
*/

{
  inputs,
  pkgs,
  hostSystem,
  ...
}:
{
  home.packages = with pkgs; [
    inputs.quickshell.packages.${hostSystem}.default

    # programs
    apostrophe
    errands
    euphonica
    gapless
    keypunch
    kitty
    libreoffice-fresh
    metadata-cleaner
    mission-center
    pdfarranger
    quick-lookup
    saber
    sly
    snapshot
    iplookup-gtk

    # gnome apps
    baobab
    decibels
    gedit
    gnome-calculator
    gnome-calendar
    gnome-clocks
    gnome-contacts
    gnome-font-viewer
    gnome-frog
    gnome-graphs
    gnome-maps
    # gnome-music
    gnome-notes
    gnome-obfuscate
    gnome-photos
    gnome-text-editor
    gnome-weather
    loupe
    seahorse
    showtime
    unstable.gImageReader

    # libraries / packages
    adw-gtk3
    adwaita-icon-theme
    adwaita-qt6
    glib
    gtk3
    kdePackages.qt6ct

    # compatibility
    libsecret
    gnome-online-accounts
    gsettings-desktop-schemas

    # for debugging
    nwg-look
  ];
}
