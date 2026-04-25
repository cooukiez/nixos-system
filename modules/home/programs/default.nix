/*
  modules/home/programs/default.nix

  created by ludw
  on 2026-02-26
*/

{
  imports = [
    ./web

    ./git.nix
    ./imv.nix
    ./vscode.nix
    ./zathura.nix
  ];
}
