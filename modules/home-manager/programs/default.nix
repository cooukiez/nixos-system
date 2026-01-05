{ pkgs, userConfig, ... }:
{
  imports = [
    ./firefox.nix
    ./git.nix
    ./thunderbird.nix
    ./zen-browser.nix
  ];
}
