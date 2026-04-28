/*
  modules/home/programs/git.nix

  created by ludw
  on 2026-02-26
*/

{
  config,
  pkgs,
  lib,
  userConfig,
  ...
}:
let
  cfg = config.programs.git;
in
{
  config = lib.mkIf cfg {
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = userConfig.gitName;
          email = userConfig.gitEmail;
        };

        credential.helper = "${lib.getExe pkgs.git-credential-manager}";
        credential.credentialStore = "secretservice";
      };
    };
  };
}
