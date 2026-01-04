{ pkgs, userConfig, ... }:
{
  imports = [
    ./firefox.nix
    ./git.nix
  ];
}
