{ pkgs, ... }: {
  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      user = {
        name  = info.github_name;
        email = info.github_email;
      };

      credential.helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
      credential.credentialStore = "secretservice";
    };
  };
}
