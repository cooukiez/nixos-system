{ pkgs, userConfig, ... }:
{
  imports = [
    ./firefox.nix
    ./git.nix
    ./kate.nix
    ./konsole.nix
    ./thunderbird.nix
    ./vscode.nix
    ./zen-browser.nix
    ./zsh.nix
  ];
}
