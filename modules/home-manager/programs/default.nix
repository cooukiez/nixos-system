{ pkgs, userConfig, ... }:
{
  imports = [
    ./firefox.nix
    ./git.nix
    ./kitty.nix
    ./thunderbird.nix
    ./vscode.nix
    ./zen-browser.nix
    ./zsh.nix
  ];
}
