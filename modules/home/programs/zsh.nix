/*
  modules/home/programs/zsh.nix

  created by ludw
  on 2026-02-23
*/

{
  userConfig,
  hostname,
  ...
}:
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
      uh = "home-manager switch --flake /etc/nixos#${userConfig.name}@${hostname}";

      nus = "nh os switch /etc/nixos#nixosConfigurations.${hostname} --update";
      nuh = "nh home switch /etc/nixos#homeConfigurations.${userConfig.name}@${hostname}.activationPackage";
      nuuh = "nh home switch /etc/nixos#homeConfigurations.${userConfig.name}@${hostname}.activationPackage --update";

      cns = "sudo sh -c 'nix-env -p /nix/var/nix/profiles/system --delete-generations old && nix-collect-garbage -d && nix-store --optimise && nix-store --verify --check-contents --repair'";
      cnh = "nix-env --delete-generations old && nix profile wipe-history && home-manager expire-generations \"-0 seconds\" && nix-collect-garbage -d";

      nd = "cd /etc/nixos";
      nk = "kate /etc/nixos";

      pwf = "edit-secret /data/upm.age";

      gtop = "sudo intel_gpu_top";

      help = "bash -c 'help'";

      c = "clear";
    };

    initContent = ''
      bindkey -e
      export EDITOR=nvim

      # enable colors
      autoload -U colors && colors

      # set prompt style
      PROMPT='%F{yellow}%n%F{blue}@%m%f:%~$ '
    '';

    history.size = 16384;
  };
}
