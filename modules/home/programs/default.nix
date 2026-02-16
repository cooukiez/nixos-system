/*
  modules/home/programs/default.nix

  created by ludw
  on 2026-02-14
*/

{
  imports = [
    ./nvim
    ./web

    ./git.nix
    ./kitty.nix
    # ./obsidian.nix
    ./vscode.nix
    ./zathura.nix
    ./zsh.nix
  ];
}
