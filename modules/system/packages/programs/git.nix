{
  programs.git = {
    enable = true;
    package = pkgs.git;

    lfs = {
      enable = true;
      package = pkgs.git-lfs;
    };

    config = {
      safe = {
        directory = [
          "/etc/nixos"
          "/data/documents/vault"
          "/data/documents/server"
        ];
      };
    };
  };
}
