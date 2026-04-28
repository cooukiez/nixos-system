/*
  modules/home/programs/zathura.nix

  created by ludw
  on 2026-02-26
*/

{
  config,
  lib,
  ...
}:
let
  cfg = config.graphicalPrograms.zathura;
in
{
  config = lib.mkIf cfg {
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
  };
}
