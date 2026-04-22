{
  inputs,
  config,
  lib,
  hostConfig,
  ...
}:
let
  cfg = config.graphicalConfig.media;
in
{
  imports = [
    inputs.spicetify-nix.nixosModules.default
  ];

  config = lib.mkIf cfg.spotify {
    programs.spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${hostConfig.hostSystem};
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
  };
}
