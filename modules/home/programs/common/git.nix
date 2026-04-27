/*
  modules/home/programs/git.nix

  created by ludw
  on 2026-02-26
*/

{
  pkgs,
  lib,
  userConfig,
  ...
}:
{
  config = lib.mkIf programs.git {
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
