/*
  modules/home/programs/default.nix

  created by ludw
  on 2026-01-29
*/

{
  imports = [
    ./nvim
    ./web

    ./git.nix
    ./kitty.nix
    ./vscode.nix
    ./zathura.nix
    ./zsh.nix
  ];
}
