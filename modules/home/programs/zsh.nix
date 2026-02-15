/*
  modules/home/programs/zsh.nix

  created by ludw
  on 2026-01-29
*/

{
  userConfig,
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
      uh = "home-manager switch --flake /etc/nixos#${userConfig.name}@lvl";

      nus = "nh os switch /etc/nixos#nixosConfigurations.lvl --update";
      nuh = "nh home switch /etc/nixos#homeConfigurations.${userConfig.name}@lvl.activationPackage";
      nuuh = "nh home switch /etc/nixos#homeConfigurations.${userConfig.name}@lvl.activationPackage --update";

      cns = "sudo sh -c 'nix-env -p /nix/var/nix/profiles/system --delete-generations old && nix-collect-garbage -d && nix-store --optimise && nix-store --verify --check-contents --repair'";
      cnu = "nix-env --delete-generations old && nix profile wipe-history && home-manager expire-generations \"-0 seconds\" && nix-collect-garbage -d";

      nd = "cd /etc/nixos";
      nk = "kate /etc/nixos";

      help = "bash -c 'help'";

      c = "clear";
    };

    initContent = ''
      bindkey -e
      export EDITOR=vim
    '';

    history.size = 16384;
  };
}
