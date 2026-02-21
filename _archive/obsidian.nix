/*
  _archive/obsidian.nix

  created by ludw
  on 2026-02-18
*/

# not in use and externally managed via git repository

{
  programs.obsidian = {
    enable = true;

    vaults.vault = {
      enable = true;
      target = "/Documents/vault";
    };
  };
}
