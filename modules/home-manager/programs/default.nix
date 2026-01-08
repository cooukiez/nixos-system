{ pkgs, userConfig, ... }:
{
  imports = [
    ./firefox.nix
    ./git.nix
    ./kate.nix
    ./konsole.nix
    ./thunderbird.nix
    ./zen-browser.nix
  ];
}
