/*
  modules/home/programs/zathura.nix

  created by ludw
  on 2026-02-23
*/

{
  programs.zathura = {
    enable = true;

    options = {
      selection-clipboard = "clipboard";
    };

    extraConfig = ''
      set font "JetBrainsMono Nerd Font 10"
      map <F9> toggle statusbar
    '';
  };
}
