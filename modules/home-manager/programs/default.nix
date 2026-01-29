/*
  modules/home-manager/programs/default.nix

  created by ludw
  on 2026-01-29
*/

{
  imports = [
    ./browsers
    ./nvim

    ./git.nix
    ./kitty.nix
    ./thunderbird.nix
    ./vscode.nix
    ./zathura.nix
    ./zsh.nix
  ];
}
