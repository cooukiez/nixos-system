/*
  modules/home/desktop/nn/packages.nix

  created by ludw
  on 2026-02-17
*/

{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    quickshell

    # programs
    kitty
    mission-center
    apostrophe
    libreoffice-fresh
    sly
    pdfarranger

    # gnome apps
    baobab
    loupe
    gedit
    seahorse
    showtime
    unstable.gImageReader
    gnome-calendar
    gnome-contacts
    gnome-maps
    gnome-frog
    gnome-notes
    gnome-music
    gnome-photos
    gnome-graphs
    gnome-clocks
    gnome-weather
    gnome-text-editor
    gnome-font-viewer
    gnome-calculator

    # libraries / packages
    adw-gtk3
    adwaita-icon-theme
    adwaita-qt6
    glib
    gtk3
    kdePackages.qt6ct

    # compatibility
    gnome-online-accounts
    gsettings-desktop-schemas
    adwaita-icon-theme
    libsecret

    # for debugging
    nwg-look
  ];
}
