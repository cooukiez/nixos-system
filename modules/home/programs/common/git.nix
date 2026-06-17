/*
modules/home/programs/common/git.nix

part of nixos system
created 2026-06-16 by ludw
*/
{
  config,
  pkgs,
  lib,
  userConfig,
  ...
}: let
  cfg = config.graphicalPrograms.git;
  githubTokenSecretFile = ../../../../secrets/ghp-classic.age;

  gitSecretHelperScript = ''
    if [ "$1" = "get" ]; then
      token=$(cat ${config.age.secrets.github-token.path})
      echo "username=${userConfig.gitName}"
      echo "password=$token"
    fi
  '';

  gitSecretHelper = pkgs.writeShellScript "git-secret-helper" gitSecretHelperScript;
in {
  config = lib.mkIf cfg {
    age.secrets.github-token.file = githubTokenSecretFile;

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
