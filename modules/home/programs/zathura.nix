/*
  modules/home/programs/zathura.nix

  created by ludw
  on 2026-02-17
*/

{
  programs.zathura = {
    enable = true;

    options = {
      selection-clipboard = "clipboard";
    };
  };
}
