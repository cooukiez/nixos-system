/*
  modules/system/packages/programs/zsh.nix

  created by ludw
  on 2026-04-22
*/

{
  config,
  lib,
  ...
}:
let
  promptFirstColor = "%F{yellow}";
  promptSecondColor = "%F{blue}";

  prompt = "${promptFirstColor}%n@${promptSecondColor}%m%f:%~$";
in
{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    enableBashCompletion = true;
    enableLsColors = true;

    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -la";
      gs = "git status";

      help = "bash -c 'help'";
      c = "clear";

      # nix system
      nd = "cd /etc/nixos";

      us = "sudo nixos-rebuild switch";
      uus = "sudo nixos-rebuild switch --upgrade-all";
      uso = "sudo nixos-rebuild switch --offline";

      nus = "nh os switch /etc/nixos";
      nuus = "nh os switch /etc/nixos --update";

      cns = "sudo sh -c 'nix-env -p /nix/var/nix/profiles/system --delete-generations old && nix-collect-garbage -d && nix-store --optimise && nix-store --verify'";

      # utility
      gtop = "sudo intel_gpu_top";
      ntop = "sudo nethogs";

      fdn = "sudo fix-perms /etc/nixos";
    }
    // lib.optionalAttrs config.packageConfig.dataPartition {
      pwf = "edit-secret /data/upm.age";
      fdp = "sudo fix-perms /data";
    };

    interactiveShellInit = ''
      bindkey -e
      export EDITOR=nvim
      autoload -U colors && colors
    '';

    promptInit = ''
      PROMPT='${prompt} '
    '';

    histSize = 16384;
  };
}
