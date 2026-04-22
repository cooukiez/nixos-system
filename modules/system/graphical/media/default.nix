{
  config,
  pkgs,
  lib,
  ...
}:
let
  media = import ./packages.nix { inherit pkgs; };
  cfg = config.graphicalConfig.media;

  mkEnableDefault = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
in
{
  options.graphicalConfig = {
    media = lib.mkOption {
      type = lib.types.submodule {
        options = {
          documentsPkg = mkEnableDefault;
          imagesPkg = mkEnableDefault;
          literaturePkg = mkEnableDefault;
          musicPkg = mkEnableDefault;
          photosPkg = mkEnableDefault;
          soundPkg = mkEnableDefault;
          videosPkg = mkEnableDefault;

          spotify = mkEnableDefault;
        };
      };

      default = { };
    };
  };

  config = {
    imports = lib.optional cfg.spotify ./spotify.nix;

    environment.systemPackages =
      (lib.optionals cfg.documentsPkg media.documents)
      ++ (lib.optionals cfg.imagesPkg media.images)
      ++ (lib.optionals cfg.literaturePkg media.literature)
      ++ (lib.optionals cfg.musicPkg media.music)
      ++ (lib.optionals cfg.photosPkg media.photos)
      ++ (lib.optionals cfg.soundPkg media.sound)
      ++ (lib.optionals cfg.videosPkg media.videos);
  };
}
