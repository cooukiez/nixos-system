{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.desktop.nn;
in
{
  config = lib.mkIf cfg {
    home.packages = with pkgs; [
      adw-gtk3
      gtk3

      adwaita-icon-theme

      adwaita-qt6
      kdePackages.qt6ct

      libsecret
      lisgd
      zenity

      gnome-online-accounts
      gsettings-desktop-schemas
    ];
  };
}
