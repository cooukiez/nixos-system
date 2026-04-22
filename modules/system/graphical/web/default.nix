{
  pkgs,
  lib,
  config,
  ...
}:
let
  web = import ./packages.nix { inherit pkgs; };
  cfg = config.graphicalConfig.web;

  mkEnableDefault = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
in
{
  imports = [
    ./firefox.nix
  ];

  options.graphicalConfig = {
    web = lib.mkOption {
      type = lib.types.submodule {
        options = {
          messengerPkg = mkEnableDefault;
          downloadPkg = mkEnableDefault;

          firefox = mkEnableDefault;
        };
      };

      default = { };
    };
  };

  config = {
    environment.systemPackages =
      (lib.optionals cfg.messengerPkg web.messenger) ++ (lib.optionals cfg.downloadPkg web.download);
  };
}
