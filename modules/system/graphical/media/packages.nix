/*
  modules/system/graphical/media/packages.nix

  created by ludw
  on 2026-04-22
*/

{
  pkgs,
  ...
}:
{
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
    upscayl
    xnviewmp
  ];

  literature = with pkgs; [
    (calibre.override {
      unrarSupport = true;
    })

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
    audacity
    muse-sounds-manager
    musescore
  ];

  videos = with pkgs; [
    davinci-resolve

    # recording
    gpu-screen-recorder
    gpu-screen-recorder-gtk
  ];
}
