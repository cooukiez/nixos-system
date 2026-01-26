{ pkgs, userConfig, ... }:
{
  imports = [
    ./firefox.nix
    ./git.nix
    ./kitty.nix
    ./thunderbird.nix
    ./vscode.nix
    ./zathura.nix
    ./zen-browser.nix
    ./zsh.nix
  ];

  programs.nvim.enable = true;
}
