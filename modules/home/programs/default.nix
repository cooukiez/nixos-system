/*
  modules/home/programs/default.nix

  created by ludw
  on 2026-02-21
*/

{
  imports = [
    ./nvim
    ./web

    ./git.nix
    ./imv.nix
    ./vscode.nix
    ./zathura.nix
    ./zsh.nix
  ];
}
