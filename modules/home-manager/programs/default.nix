/*
  modules/home-manager/programs/default.nix

  created by ludw
  on 2026-01-01
*/

{ pkgs, userConfig, ... }:
{
  imports = [
    ./nvim

    ./firefox.nix
    ./git.nix
    ./kitty.nix
    ./thunderbird.nix
    ./vscode.nix
    ./zathura.nix
    ./zen-browser.nix
    ./zsh.nix
  ];
}
