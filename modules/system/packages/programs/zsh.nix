/*
modules/system/packages/programs/zsh.nix

part of nixos system
created 2026-04-22 by ludw
*/
{
  config,
  lib,
  ...
}: let
  cfg = config.zshSettings;

  mkPrompt = userColor: systemColor: let
    promptFirstColor = "%F{${userColor}}";
    promptSecondColor = "%F{${systemColor}}";
  in "${promptFirstColor}%n@${promptSecondColor}%m%f:%~$";

  mkDisableDefault = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };
in {
  options.zshSettings = {
    userColor = lib.mkOption {
      type = lib.types.str;
      default = "yellow";
    };

    systemColor = lib.mkOption {
      type = lib.types.str;
      default = "blue";
    };

    dataPartitionAliases = mkDisableDefault;
    containerImageAliases = mkDisableDefault;
  };

  config = {
    programs.zsh = {
      enable = true;

      enableCompletion = true;
      enableBashCompletion = true;
      enableLsColors = true;

      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases =
        {
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

          cns = ''
            sudo sh -c '
              nix-env -p /nix/var/nix/profiles/system --delete-generations old && \
              nix-collect-garbage -d && \
              nix-store --optimise && \
              nix-store --verify
            '
          '';

          refresh-nix-headers = "cd /etc/nixos && nix run nixpkgs#python3 -- /etc/nixos/refresh-headers.py";

          # utility
          gtop = "sudo intel_gpu_top";
          ntop = "sudo nethogs";

          fdn = "sudo fix-perms /etc/nixos";
        }
        // lib.optionalAttrs cfg.dataPartitionAliases {
          pwf = "edit-secret /data/upm.age";
          fdp = "sudo fix-perms /data";
        }
        // lib.optionalAttrs cfg.containerImageAliases {
          update-images = ''
            nix shell nixpkgs#skopeo nixpkgs#nix-prefetch-docker nixpkgs#python3 \
              --command python3 /etc/nixos/fetch-images.py
          '';
        };

      interactiveShellInit = ''
        bindkey -e
        export EDITOR=nvim
        autoload -U colors && colors
      '';

      promptInit = ''
        PROMPT='${mkPrompt cfg.userColor cfg.systemColor} '
      '';

      histSize = 16384;
    };
  };
}
