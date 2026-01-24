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

    glib
    gsettings-desktop-schemas
    gnome-themes-extra
    adw-gtk3
    adwaita-qt6
    kdePackages.qt6ct
    adwaita-icon-theme
    gtk3

    # controls
    playerctl
    brightnessctl

    # compatibility
    gnome-keyring
    nautilus

    # for debugging
    nwg-look
  ];
}
