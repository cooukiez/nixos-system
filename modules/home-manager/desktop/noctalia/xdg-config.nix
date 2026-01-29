/*
  modules/home-manager/desktop/noctalia/xdg-config.nix

  created by ludw
  on 2026-01-24
*/


{ config, pkgs, ... }:
let
  disabled_desktop_entry = ''
    [Desktop Entry]
    Type=Application
    Name=disabled-application
    Exec=false
    NoDisplay=true
  '';
in
{
  xdg = {
    enable = true;

    autostart = {
      enable = true;
      readOnly = true;
      entries = [ ];
    };

    portal = {
      enable = true;
      xdgOpenUsePortal = true;

      configPackages = with pkgs; [
        #gnome.gnome-session
      ];

      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
      ];

      config = {
        common = {
          default = [
            "gtk"
          ];
          "org.freedesktop.impl.portal.Secret" = [
            "gnome-keyring"
          ];
        };
      };
    };

    mimeApps = {
      enable = true;

      defaultApplications = {
        # text
        "text/plain" = [ "org.gnome.gedit.desktop" ];

        # pdf
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];

        # images
        "image/png" = [ "loupe.desktop" ];
        "image/jpeg" = [ "loupe.desktop" ];
        "image/webp" = [ "loupe.desktop" ];
        "image/gif" = [ "loupe.desktop" ];
        "image/bmp" = [ "loupe.desktop" ];

        # videos
        "video/mp4" = [ "showtime.desktop" ];
        "video/x-matroska" = [ "showtime.desktop" ];
        "video/webm" = [ "showtime.desktop" ];
        "video/x-msvideo" = [ "showtime.desktop" ];

        # directories
        "inode/directory" = [ "thunar.desktop" ];

        # browser
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
        "text/html" = [ "firefox.desktop" ];
      };
    };
  };

  xdg.dataFile."applications/kdesystemsettings.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.kmenuedit.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/systemsettings.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.kinfocenter.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.plasma-systemmonitor.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.plasma.emojier.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/kwalletmanager5-kwalletd.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.kwalletmanager.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.drkonqi.coredump.gui.desktop".text = disabled_desktop_entry;
}
