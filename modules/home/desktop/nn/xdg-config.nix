# modules/home/desktop/nn/xdg-config.nix

{ ... }:

let
  disabled = ''
    [Desktop Entry]
    Type=Application
    Name=disabled
    Exec=false
    NoDisplay=true
  '';

  # editors
  editors = {
    general = [ "code.desktop" ];
    intermediate = [ "code.desktop" ];
    python = [ "pycharm.desktop" ];
    java = [ "idea.desktop" ];
    cpp = [ "clion.desktop" ];
    rust = [ "rust-rover.desktop" ];
  };

  apps = {
    pdf = [ "org.pwmt.zathura.desktop" ];
    image = [ "imv.desktop" ];
    imageBackup = [ "org.gnome.Loupe.desktop" ];
    audio = [ "org.gnome.Music.desktop" ];
    video = [ "org.gnome.Showtime.desktop" ];
    archive = [ "org.gnome.Nautilus.desktop" ];
    file = [ "org.gnome.Nautilus.desktop" ];
    browser = [ "firefox.desktop" ];
  };

  # helper to assign one app to many mime types
  forTypes =
    types: app:
    builtins.listToAttrs (
      map (t: {
        name = t;
        value = app;
      }) types
    );

  # grouped mime definitions
  mimeDefaults =
    (forTypes [
      "text/plain"
      "application/octet-stream"

      "application/xml"
      "text/xml"

      "text/x-yaml"
      "application/x-yaml"

      "application/toml"

      "text/csv"

      "application/json"
      "application/ld+json"
      "text/json"

      "application/x-shellscript"
      "text/x-shellscript"
    ] editors.general)

    //

      (forTypes [
        "text/x-python"
        "application/x-python-code"

        "text/x-java"
        "text/x-java-source"

        "text/x-c"
        "text/x-c++"
        "text/x-c++src"
        "text/x-chdr"
        "text/x-c++hdr"

        "text/rust"
        "text/x-rust"

        "text/html"
        "application/xhtml+xml"

        "text/css"

        "application/javascript"
        "text/javascript"

        "application/x-typescript"

        "text/x-php"
        "application/x-php"

        "text/x-nix"
      ] editors.intermediate)

    //

      (forTypes [ "application/pdf" ] apps.pdf)

    //

      (forTypes [
        "image/png"
        "image/jpeg"
        "image/webp"
        "image/gif"
        "image/bmp"
        "image/tiff"
        "image/svg+xml"
        "image/heif"
        "image/heic"
        "image/x-xcf"
      ] apps.image)

    //

      (forTypes [ "image/ico" ] apps.imageBackup)

    //

      (forTypes [
        "audio/mpeg"
        "audio/flac"
        "audio/ogg"
        "audio/wav"
      ] apps.audio)

    //

      (forTypes [
        "video/mp4"
        "video/webm"
        "video/x-matroska"
        "video/x-msvideo"
        "video/quicktime"
        "video/mpeg"
        "video/ogg"
      ] apps.video)

    //

      (forTypes [
        "application/zip"
        "application/x-tar"
        "application/x-gzip"
        "application/x-bzip2"
        "application/x-7z-compressed"
        "application/x-rar"
      ] apps.archive)

    //

      (forTypes [ "inode/directory" ] [ "thunar.desktop" ])

    //

      (forTypes [
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/about"
        "x-scheme-handler/unknown"
      ] apps.browser);

  disabledDesktopEntries = [
    "kdesystemsettings.desktop"
    "org.kde.kmenuedit.desktop"
    "systemsettings.desktop"
    "org.kde.kinfocenter.desktop"
    "org.kde.plasma-systemmonitor.desktop"
    "org.kde.dolphin.desktop"
    "org.kde.kwrite.desktop"
    "org.kde.plasma.emojier.desktop"
    "org.kde.kate.desktop"
    "org.kde.ark.desktop"
    "org.kde.elisa.desktop"
    "org.kde.okular.desktop"
    "org.kde.konsole.desktop"
    "org.kde.khelpcenter.desktop"
    "org.kde.discover.desktop"
    "org.kde.gwenview.desktop"
    "org.kde.spectacle.desktop"
    "kwalletmanager5-kwalletd.desktop"
    "org.kde.kwalletmanager.desktop"
    "org.kde.drkonqi.coredump.gui.desktop"
  ];

in
{
  xdg = {
    enable = true;

    autostart = {
      enable = true;
      readOnly = true;
      entries = [ ];
    };

    portal.config.common."org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];

    configFile."mimeapps.list".force = true;

    mimeApps = {
      enable = true;
      defaultApplications = mimeDefaults;
    };
  };

  xdg.dataFile = builtins.listToAttrs (
    map (name: {
      name = "applications/${name}";
      value.text = disabled;
    }) disabledDesktopEntries
  );
}
