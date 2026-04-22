/*
  modules/nixos/programs/cli-tools.nix

  created by ludw
  on 2026-02-26
*/

{
  pkgs,
  ...
}:
let
  clear-logs = pkgs.writeShellScriptBin "clear-logs" (builtins.readFile ./scripts/clear-logs.sh);
  cp-fonts = pkgs.writeShellScriptBin "cp-fonts" (builtins.readFile ./scripts/cp-fonts.sh);
  del-snaps = pkgs.writeShellScriptBin "del-snaps" (builtins.readFile ./scripts/del-snaps.sh);
  edit-secret = pkgs.writeShellScriptBin "edit-secret" (builtins.readFile ./scripts/edit-secret.sh);
  fix-perms = pkgs.writeShellScriptBin "fix-perms" (builtins.readFile ./scripts/fix-perms.sh);
  snaps-du = pkgs.writeShellScriptBin "snaps-du" (builtins.readFile ./scripts/snaps-du.sh);
  sync-flake = pkgs.writeShellScriptBin "sync-flake" (builtins.readFile ./scripts/sync-flake.sh);
in
{
  programs.nix-ld.enable = true;
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/etc/nixos"; # sets NH_OS_FLAKE variable for you
  };

  # nvim base editor
  programs.neovim.enable = true;

  environment.systemPackages = with pkgs; [
    ### tui tools, sorted alphabetically ###

    ### cli tools, sorted alphabetically ###

    # my system tools
    clear-logs
    cp-fonts
    del-snaps
    edit-secret
    fix-perms
    snaps-du
    sync-flake

    # playful tools
  ];
}
