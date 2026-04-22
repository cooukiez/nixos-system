let
  promptFirstColor = "%F{yellow}";
  promptSecondColor = "%F{blue}";
in
{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -la";
      gs = "git status";

      help = "bash -c 'help'";
      c = "clear";

      pwf = "edit-secret /data/upm.age";

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
    };

    interactiveShellInit = ''
      bindkey -e
      export EDITOR=nvim
      autoload -U colors && colors
    '';

    promptInit = ''
      PROMPT='${promptFirstColor}%n@${promptSecondColor}%m%f:%~$ '
    '';

    histSize = 16384;
  };
}
