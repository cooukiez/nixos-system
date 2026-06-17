/*
modules/system/graphical/media/packages.nix

part of nixos system
created 2026-04-22 by ludw
*/
{
  config,
  pkgs,
  ...
}: {
  documents = with pkgs; [
    affine
    onlyoffice-desktopeditors
    rnote
    scribus
    obsidian
    pdfpc
    sioyek
    texstudio
    zathura
    zathuraPkgs.zathura_core
    zathuraPkgs.zathura_pdf_mupdf
  ];

  images = with pkgs; [
    gimp-with-plugins
    inkscape
    ipe
    krita
    pinta
    sxiv
    tuxpaint
    upscayl
    xnviewmp
  ];

  literature = with pkgs; [
    /*
    (calibre.override {
      unrarSupport = true;
    })
    */

    zotero
  ];

  music = with pkgs; [
    audacious
    audacious-plugins
    feishin
    kdePackages.k3b
    mpv
    picard
    shutter
    vlc
  ];

  photos = with pkgs; [
    darktable
    digikam
    rapid-photo-downloader
  ];

  sound = with pkgs; [
    ardour
    audacity
    cardinal
    easyeffects
    hydrogen
    lmms-full
    muse-sounds-manager
    musescore
    paulstretch
    sonic-visualiser
  ];

  videos = with pkgs;
    [
      kdePackages.kdenlive
      openshot-qt
      shotcut

      # recording
      gpu-screen-recorder
      gpu-screen-recorder-gtk
    ]
    ++ lib.optionals config.packageConfig.gpuPowerApps [
      davinci-resolve
    ];
}
