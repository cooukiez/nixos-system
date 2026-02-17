/*
  modules/home/programs/zathura.nix

  created by ludw
  on 2026-02-16
*/

{
  programs.zathura = {
    enable = true;

    options = {
      selection-clipboard = "clipboard";
    };
  };
}
