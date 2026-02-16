/*
  modules/nixos/programs/media.nix

  created by ludw
  on 2026-02-16
*/

{
  inputs,
  hostSystem,
  pkgs,
  ...
}:
{
  # enable usage of headset buttons to control media playback
  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [
      "network.target"
      "sound.target"
    ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  environment.systemPackages = with pkgs; [
    # video players (some support audio too)
    vlc
    mpv

    # audio
    spotify
    strawberry

    # image viewers
    xnviewmp
    sxiv
    imv

    # camera suite
    gphoto2

    # pdf
    sioyek
    zathura
    zathuraPkgs.zathura_core
    zathuraPkgs.zathura_pdf_mupdf
  ];

  # extensions for spotify, directly wrapping spotify
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
