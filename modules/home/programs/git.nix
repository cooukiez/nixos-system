/*
  modules/home/programs/git.nix

  created by ludw
  on 2026-02-14
*/

{
  pkgs,
  userConfig,
  ...
}:
{
  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      user = {
        name = userConfig.githubName;
        email = userConfig.githubEmail;
      };

      credential.helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
      credential.credentialStore = "secretservice";

      advice.defaultBranchName = false;

      safe = {
        directory = [ "/etc/nixos" ];
      };
    };
  };
}
