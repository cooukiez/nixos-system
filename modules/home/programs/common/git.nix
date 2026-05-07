/*
  modules/home/programs/common/git.nix

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
  cfg = config.graphicalPrograms.git;

  gitSecretHelper = pkgs.writeShellScript "git-secret-helper" ''
    if [ "$1" = "get" ]; then
      token=$(cat ${config.age.secrets.github-token.path})
      echo "username=${userConfig.gitName}"
      echo "password=$token"
    fi
  '';
in
{
  config = lib.mkIf cfg {
    age.secrets.github-token.file = ../../../../secrets/github-token.age;

    programs.git = {
      enable = true;

      settings = {
        user = {
          name = userConfig.gitName;
          email = userConfig.gitEmail;
        };

        credential.helper = "${gitSecretHelper}";
        credential.credentialStore = "secretservice";
      };
    };
  };
}
