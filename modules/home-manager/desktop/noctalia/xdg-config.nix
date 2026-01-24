{ config, pkgs, ... }:
{
  xdg = {
    enable = true;

    portal.config = {
      common = {
        default = [
          "gtk"
        ];
        "org.freedesktop.impl.portal.Secret" = [
          "gnome-keyring"
        ];
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
        "image/png" = [ "imv.desktop" ];
        "image/jpeg" = [ "imv.desktop" ];
        "image/webp" = [ "imv.desktop" ];
        "image/gif" = [ "imv.desktop" ];
        "image/bmp" = [ "imv.desktop" ];

        # videos
        "video/mp4" = [ "mpv.desktop" ];
        "video/x-matroska" = [ "mpv.desktop" ];
        "video/webm" = [ "mpv.desktop" ];
        "video/x-msvideo" = [ "mpv.desktop" ];

        # directories
        "inode/directory" = [ "thunar.desktop" ];

        # browser
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
        "text/html" = [ "firefox.desktop" ];
      };
    };

    desktopEntries."kmenuedit.desktop" = {
      noDisplay = true;
    };
  };
}
