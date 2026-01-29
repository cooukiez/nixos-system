{

  environment.systemPackages = with pkgs; [
    # video players (some support audio too)
    vlc
    mpv

    # audio
    spotify
    strawberry

    # image viewers
    sxiv
    imv

    # pdf
    sioyek
    zathura
    zathuraPkgs.zathura_core
    zathuraPkgs.zathura_pdf_mupdf
  ];

  # extensions for spotify, directly wrapping spotify
  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
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
