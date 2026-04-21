{
  pkgs,
  lib,
  config,
  ...
}:
let
  web = import ./packages.nix { inherit pkgs; };
  cfg = config.graphicalPkgWeb;
in
{
  options.graphicalPkgWeb = {
    firefox = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    messenger = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    download = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = {
    imports = lib.optional cfg.firefox ./firefox.nix;

    environment.systemPackages =
      (lib.optionals cfg.messenger web.messenger) ++ (lib.optionals cfg.download web.download);
  };
}
