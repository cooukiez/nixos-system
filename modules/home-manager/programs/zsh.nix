{ pkgs, userConfig, ... }:
{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -la";
      gs = "git status";

      update-system = "sudo nixos-rebuild switch";
      update-home = "home-manager switch --flake /etc/nixos#'ludw@lvl'";
    };

    initExtra = ''
      bindkey -v
      export EDITOR=vim
    '';
  };
}
