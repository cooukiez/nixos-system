{ pkgs, userConfig, ... }: {
  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      user = {
        name  = userConfig.githubName;
        email = userConifg.githubEmail;
      };

      credential.helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
      credential.credentialStore = "secretservice";
    };
  };
}
