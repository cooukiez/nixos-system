/*
modules/home/programs/common/zathura.nix

part of nixos system
created 2026-02-26 by ludw
*/
{
  config,
  lib,
  ...
}: let
  cfg = config.graphicalPrograms.zathura;
in {
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
