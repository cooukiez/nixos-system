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

    glib
    gsettings-desktop-schemas
    gnome-themes-extra
    adw-gtk3
    adwaita-qt6
    adwaita-icon-theme
    gtk3
    gtk4
    kdePackages.qt6ct

    # controls
    playerctl
    brightnessctl

    # extra
    gnome-keyring

    # for debugging
    nwg-look
  ];
}
