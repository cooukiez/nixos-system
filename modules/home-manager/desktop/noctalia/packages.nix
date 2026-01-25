{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    quickshell

    # packages for noctalia
    kitty
    mission-center
    apostrophe
    libreoffice-fresh
    sly

    # gnome apps
    loupe
    gedit
    seahorse
    showtime
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
    glib
    gtk3
    adw-gtk3
    adwaita-qt6
    kdePackages.qt6ct
    gnome-themes-extra
    adwaita-icon-theme
    gsettings-desktop-schemas

    # compatibility
    gnome-online-accounts
    libsecret

    # for debugging
    nwg-look
  ];
}
