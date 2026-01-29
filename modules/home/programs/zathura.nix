/*
  modules/home-manager/programs/zathura.nix

  created by ludw
  on 2026-01-29
*/

{
  programs.zathura.enable = true;

  programs.zathura.options = {
    selection-clipboard = "clipboard";
  };
}
