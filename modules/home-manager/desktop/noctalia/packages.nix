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
    gnome-calendar
    menulibre
    gedit
    seahorse

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
    nautilus

    # for debugging
    nwg-look
  ];
}
