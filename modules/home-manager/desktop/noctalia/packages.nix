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
    nautilus
    gnome-calendar
    gnome-contacts
    menulibre
    gedit
    seahorse
    libreoffice-fresh # libreoffice-fresh gtk version
    showtime
    #menulibre
    sly
    gnome-maps
    gnome-frog
    gnome-notes
    gnome-music
    gnome-photos
    gnome-graphs
    gnome-clocks
    gnome-weather
    #gnome-commander
    gnome-text-editor
    gnome-font-viewer
    gnome-calculator
    loupe

    glib
    gsettings-desktop-schemas
    gnome-themes-extra
    adw-gtk3
    adwaita-qt6
    kdePackages.qt6ct
    adwaita-icon-theme
    gtk3
    libsecret

    # controls
    playerctl
    brightnessctl

    # compatibility
    gnome-online-accounts

    # for debugging
    nwg-look
  ];
}
