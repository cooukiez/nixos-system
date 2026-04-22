{
  inputs,
  hostSystem,
  ...
}:
let
  packages = import ./packages.nix { inherit pkgs; };
  cfg = config.graphicalConfig;

  mkEnableDefault = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
in
{
  imports = [
    # General Groups
    pkgLib.core
    pkgLib.dev
    pkgLib.utils
    pkgLib.nix-utils

    # System & Hardware
    pkgLib.hardware
    pkgLib.filesystem

    # Networking & Security
    pkgLib.secrets

    # Media
    pkgLib.media
  ];
}
