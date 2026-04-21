{ pkgs, ... }:
let
  desktop = import ./packages.nix { inherit pkgs; };
in
{
  environment.systemPackages = desktop.desktopCore ++ desktop.desktopQt ++ desktop.desktopAppmenu;
}
