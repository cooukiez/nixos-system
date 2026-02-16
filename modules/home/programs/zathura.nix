/*
  modules/home/programs/zathura.nix

  created by ludw
  on 2026-02-14
*/

{
  programs.zathura.enable = true;

  programs.zathura.options = {
    selection-clipboard = "clipboard";
  };
}
