{
  pkgs,
  ...
}:
{
  programs.git = {
    enable = true;
    package = pkgs.git;

    lfs = {
      enable = true;
      package = pkgs.git-lfs;
    };

    config = {
      advice.defaultBranchName = false;

      pull.rebase = true;
      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };

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
