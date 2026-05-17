/*
modules/system/packages/programs/git.nix

part of nixos system
created 2026-04-23 by ludw
*/
{pkgs, ...}: {
  programs.git = {
    enable = true;
    package = pkgs.git;

    lfs = {
      enable = true;
      package = pkgs.git-lfs;
    };

    config = {
      advice.defaultBranchName = false;

      pull.rebase = true;
      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };

      safe = {
        directory = [
          "/etc/nixos"
          "/data/vault"
          "/data/documents/vault"
          "/data/documents/server"
        ];
      };
    };
  };
}
