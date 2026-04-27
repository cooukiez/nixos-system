/*
  modules/home/programs/git.nix

  created by ludw
  on 2026-02-26
*/

{
  pkgs,
  userConfig,
  ...
}:
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = userConfig.gitName;
        email = userConfig.gitEmail;
      };

      credential.helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
      credential.credentialStore = "secretservice";
    };
  };
}
