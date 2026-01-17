{ pkgs, userConfig, ... }:
{
  imports = [
    ./firefox.nix
    ./git.nix
    ./spicetify.nix
    ./thunderbird.nix
    ./vscode.nix
    ./zen-browser.nix
    ./zsh.nix
  ];
}
