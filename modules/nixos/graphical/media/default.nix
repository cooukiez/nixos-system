{
  config,
  pkgs,
  lib,
  ...
}:
let
  media = import ./packages.nix { inherit pkgs; };
  cfg = config.graphicalPkgMedia;
in
{
  options.graphicalPkgMedia = {
    spotify = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    documents = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    images = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    music = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    photos = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    sound = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    videos = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = {
    imports = lib.optional cfg.spotify ./spotify.nix;

    environment.systemPackages =
      (lib.optionals cfg.documents media.documents)
      ++ (lib.optionals cfg.images media.images)
      ++ (lib.optionals cfg.music media.music)
      ++ (lib.optionals cfg.photos media.photos)
      ++ (lib.optionals cfg.sound media.sound)
      ++ (lib.optionals cfg.videos media.videos);
  };
}
