{
  pkgs,
  ...
}:
{
  documents = with pkgs; [
    pdfpc
    sioyek
    zathura
    zathuraPkgs.zathura_core
    zathuraPkgs.zathura_pdf_mupdf
  ];

  images = with pkgs; [
    gimp-with-plugins
    # gthumb
    inkscape
    ipe
    krita
    pinta
    sxiv
    upscayl
    xnviewmp
  ];

  music = with pkgs; [
    audacious
    audacious-plugins
    feishin
    kdePackages.k3b
    mpv
    picard
    vlc
  ];

  photos = with pkgs; [
    darktable
    digikam
    rapid-photo-downloader
  ];

  sound = with pkgs; [
    audacity
  ];

  videos = with pkgs; [
    davinci-resolve
  ];
}
