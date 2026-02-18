/*
  modules/home/programs/default.nix

  created by ludw
  on 2026-02-17
*/

{
  imports = [
    ./nvim
    ./web

    ./git.nix
    ./vscode.nix
    ./zathura.nix
    ./zsh.nix
  ];
}
