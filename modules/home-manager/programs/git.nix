{ pkgs, userConfig, ... }:
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

      safe = {
        directory = [ "/etc/nixos" ];
      };
    };
  };
}
