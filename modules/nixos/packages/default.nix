{
  inputs,
  hostSystem,
  ...
}:

let
  # Import the package library file
  pkgLib = import ./core.nix { inherit inputs hostSystem; };
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
