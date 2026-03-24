/*
  modules/nixos/programs/media.nix

  created by ludw
  on 2026-02-26
*/

{
  inputs,
  hostSystem,
  pkgs,
  ...
}:
{
  # enable usage of headset buttons to control media playback
  /*
    systemd.user.services.mpris-proxy = {
      description = "Mpris proxy";
      after = [
        "network.target"
        "sound.target"
      ];
      wantedBy = [ "default.target" ];
      serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    };
  */

  environment.systemPackages = with pkgs; [
    audacious
    audacious-plugins
    audacity
    darktable
    davinci-resolve
    digikam
    feishin
    gimp-with-plugins
    gthumb
    inkscape
    ipe
    krita
    mpv
    picard
    pinta
    rapid-photo-downloader
    rapidraw
    sioyek
    spotify
    sxiv
    upscayl
    vlc
    xnviewmp
    zathura
    zathuraPkgs.zathura_core
    zathuraPkgs.zathura_pdf_mupdf
  ];

  programs.k3b.enable = true;

  # directly wrapping spotify
  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${hostSystem};
    in
    {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        # hidePodcasts
        shuffle
      ];
      enabledCustomApps = with spicePkgs.apps; [
        marketplace
        lyricsPlus
        newReleases
        # ncsVisualizer
      ];
      enabledSnippets = with spicePkgs.snippets; [
        rotatingCoverart
        # pointer
      ];
    };
}
