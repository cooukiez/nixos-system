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
  cfg = config.graphicalPrograms.obsidian;
in
{
  config = lib.mkIf cfg {
    programs.obsidian = {
      enable = true;
      cli.enable = true;

      vaults.vault = {
        enable = true;
        target = "Vault";
      };
    };
  };
}
