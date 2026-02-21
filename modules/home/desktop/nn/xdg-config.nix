/*
  modules/home/desktop/nn/xdg-config.nix

  created by ludw
  on 2026-02-18
*/

{
  pkgs,
  ...
}:
let
  disabled_desktop_entry = ''
    [Desktop Entry]
    Type=Application
    Name=disabled-application
    Exec=false
    NoDisplay=true
  '';

  # default applications
  general-editor = [ "code.desktop" ];
  intermediate-editor = [ "code.desktop" ];

  python-editor = [ "pycharm.desktop" ];
  java-editor = [ "idea.desktop" ];
  cpp-editor = [ "clion.desktop" ];
  rust-editor = [ "rust-rover.desktop" ];
  json-editor = [ "code.desktop" ];

  # web-source-editor = [ "webstorm.desktop" ];
  # php-editor = [ "phpstorm.desktop" ];

  pdf-viewer = [ "org.pwmt.zathura.desktop" ];

  image-viewer = [ "imv.desktop" ];
  backup-image-viewer = [ "org.gnome.Loupe.desktop" ];

  audio-player = [ "org.gnome.Music.desktop" ];
  video-player = [ "org.gnome.Showtime.desktop" ];

  archive-manager = [ "org.gnome.Nautilus.desktop" ];
  file-manager = [ "org.gnome.Nautilus.desktop" ];

  browser = [ "firefox.desktop" ];
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
      config = {
        common = {
          "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        };
      };
    };

    configFile."mimeapps.list".force = true;
    dataFile."applications/mimeapps.list".force = true;

    mimeApps = {
      enable = true;

      defaultApplications = {
        # plain text
        "text/plain" = general-editor;
        "application/octet-stream" = general-editor;

        # pyhton
        "text/x-python" = python-editor;
        "application/x-python-code" = python-editor;

        # json
        "application/json" = json-editor;
        "application/ld+json" = json-editor;
        "text/json" = json-editor;

        # java
        "text/x-java" = java-editor;
        "text/x-java-source" = java-editor;

        # c / cpp
        "text/x-c" = cpp-editor;
        "text/x-c++" = cpp-editor;
        "text/x-c++src" = cpp-editor;
        "text/x-chdr" = cpp-editor;
        "text/x-c++hdr" = cpp-editor;

        # rust
        "text/rust" = rust-editor;
        "text/x-rust" = rust-editor;

        # web source, with intermediate editor
        "text/html" = intermediate-editor;
        "application/xhtml+xml" = intermediate-editor;
        "text/css" = intermediate-editor;
        "application/javascript" = intermediate-editor;
        "text/javascript" = intermediate-editor;
        "application/x-typescript" = intermediate-editor;

        # php
        "text/x-php" = intermediate-editor;
        "application/x-php" = intermediate-editor;

        # nix
        "text/x-nix" = intermediate-editor;

        # config / markup / data
        "application/xml" = general-editor;
        "text/xml" = general-editor;
        "text/x-yaml" = general-editor;
        "application/x-yaml" = general-editor;
        "application/toml" = general-editor;
        "text/csv" = general-editor;

        # shell
        "application/x-shellscript" = general-editor;
        "text/x-shellscript" = general-editor;

        # pdf
        "application/pdf" = pdf-viewer;

        # images
        "image/png" = image-viewer;
        "image/jpeg" = image-viewer;
        "image/webp" = image-viewer;
        "image/ico" = backup-image-viewer;
        "image/gif" = image-viewer;
        "image/bmp" = image-viewer;
        "image/tiff" = image-viewer;
        "image/svg+xml" = image-viewer;
        "image/heif" = image-viewer;
        "image/heic" = image-viewer;
        "image/x-xcf" = image-viewer;

        # audio
        "audio/mpeg" = audio-player;
        "audio/flac" = audio-player;
        "audio/ogg" = audio-player;
        "audio/wav" = audio-player;

        # videos
        "video/mp4" = video-player;
        "video/webm" = video-player;
        "video/x-matroska" = video-player;
        "video/x-msvideo" = video-player;
        "video/quicktime" = video-player;
        "video/mpeg" = video-player;
        "video/ogg" = video-player;

        # archives
        "application/zip" = archive-manager;
        "application/x-tar" = archive-manager;
        "application/x-gzip" = archive-manager;
        "application/x-bzip2" = archive-manager;
        "application/x-7z-compressed" = archive-manager;
        "application/x-rar" = archive-manager;

        # directories
        "inode/directory" = [ "thunar.desktop" ];

        # browser
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "x-scheme-handler/about" = browser;
        "x-scheme-handler/unknown" = browser;
      };
    };
  };

  # remove system wide app entries from start menu
  # see /run/current-system/sw/share/applications
  xdg.dataFile."applications/kdesystemsettings.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.kmenuedit.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/systemsettings.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.kinfocenter.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.plasma-systemmonitor.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.dolphin.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.kwrite.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.plasma.emojier.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.kate.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.ark.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.elisa.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.okular.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.konsole.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.khelpcenter.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.discover.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.gwenview.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.spectacle.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/kwalletmanager5-kwalletd.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.kwalletmanager.desktop".text = disabled_desktop_entry;
  xdg.dataFile."applications/org.kde.drkonqi.coredump.gui.desktop".text = disabled_desktop_entry;
}
