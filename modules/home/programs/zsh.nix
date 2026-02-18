/*
  modules/home/programs/zsh.nix

  created by ludw
  on 2026-02-17
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
      cnh = "nix-env --delete-generations old && nix profile wipe-history && home-manager expire-generations \"-0 seconds\" && nix-collect-garbage -d";

      nd = "cd /etc/nixos";
      nk = "kate /etc/nixos";

      gtop = "sudo intel_gpu_top";

      help = "bash -c 'help'";

      c = "clear";
    };

    initContent = ''
      bindkey -e
      export EDITOR=vim

      # enable colors
      autoload -U colors && colors

      # set prompt style
      PROMPT='%F{yellow}%n%F{blue}@%m%f:%~$ '

      fixperms() {
        if [ -z "$1" ]; then
          echo "please provide a directory."
          return 1
        fi

        sudo chmod -R 775 "$1"
        sudo chmod -R g+s "$1"
        sudo chown -R root:users "$1"
      }

      editsecret() {
        local SECURE_FILE=$1
        local PUBLIC_KEY="age1ly49z83aaalg38yr4fl24nhu4cvl0467rcsx6lnp9s4eklcer3tqjmnv4p"
        local KEY_FILE="/data/key.age"
        
        # create secure temp file in RAM (if /dev/shm exists) or protected temp dir
        local TMP_FILE=$(mktemp /tmp/age-edit.XXXXXX)
        trap "rm -f $TMP_FILE" EXIT

        # decrypt if the file already exists
        if [[ -f "$SECURE_FILE" ]]; then
          # this will prompt for password to unlock the private key
          age -d -i <(age -d "$KEY_FILE") "$SECURE_FILE" > "$TMP_FILE"
        fi

        # open in nvim
        nvim "$TMP_FILE"

        # re-encrypt on exit using the public key
        age -r "$PUBLIC_KEY" -o "$SECURE_FILE" "$TMP_FILE"
        
        echo "File re-encrypted and saved to $SECURE_FILE"
      }
    '';

    history.size = 16384;
  };
}
