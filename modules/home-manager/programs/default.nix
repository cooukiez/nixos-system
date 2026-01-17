{ pkgs, userConfig, ... }:
{
  imports = [
    ./firefox.nix
    ./git.nix
    ./thunderbird.nix
    ./vscode.nix
    ./zen-browser.nix
    ./zsh.nix
  ];
}
