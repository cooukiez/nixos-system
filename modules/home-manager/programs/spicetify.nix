{ pkgs, userConfig, ... }:
{
  imports = [
    inputs.spicetify-nix.nixosModules.default
  ];

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