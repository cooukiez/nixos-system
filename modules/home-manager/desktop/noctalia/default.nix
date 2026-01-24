{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./niri.nix
    ./packages.nix
    ./style.nix
    ./xdg-config.nix
  ];

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
  };

  services.gnome-keyring = {
    enable = true;
    components = [
      "pkcs11"
      "secrets"
      "ssh"
    ];
  };

  # fix for vscode keyring
  home.file.".vscode/argv.json".text = ''
        {
          "password-store": "gnome-libsecret",
    	    "enable-crash-reporter": true,
    	    "enable-crash-reporter": true
        }
  '';

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
  };

  systemd.user.services.noctalia = {
    Unit = {
      Description = "Noctalia Shell";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.quickshell}/bin/qs -c noctalia-shell";
      Restart = "on-failure";
      RestartSec = 1;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
