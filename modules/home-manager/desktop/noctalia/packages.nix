{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # packages for noctalia
    kitty
    mission-center
    apostrophe

    glib
    gsettings-desktop-schemas
    gnome-themes-extra
    adw-gtk3
    adwaita-qt
    adwaita-qt6
    adwaita-icon-theme

    # for debugging
    nwg-look
  ];
}
