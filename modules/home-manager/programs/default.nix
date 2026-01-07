{ pkgs, userConfig, ... }:
{
  imports = [
    ./firefox.nix
    ./git.nix
    ./kate.nix
    ./thunderbird.nix
    ./zen-browser.nix
  ];
}
