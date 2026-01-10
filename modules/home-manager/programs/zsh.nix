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

      us = "sudo nixos-rebuild switch --upgrade-all";
      uh = "home-manager switch --flake /etc/nixos#'ludw@lvl'";

      nus = "nh os switch /etc/nixos#nixosConfigurations.lvl --update";
      nuh = "nh home switch /etc/nixos#homeConfigurations.ludw@lvl.activationPackage";
      nuuh = "nh home switch /etc/nixos#homeConfigurations.ludw@lvl.activationPackage --update";

      nixos-kate = "kate /etc/nixos";

      help = "bash -c 'help'";

      c = "clear";
    };

    initContent = ''
      bindkey -v
      export EDITOR=vim
    '';

    history.size = 16384;
  };
}
