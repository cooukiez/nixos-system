/*
  modules/home/desktop/nn/default.nix

  created by ludw
  on 2026-02-21
*/

{
  pkgs,
  lib,
  ...
}:
let
  formattedWeather = pkgs.writeShellScript "formatted-weather" (
    builtins.readFile ./scripts/formatted-weather.sh
  );
in
{
  imports = [
    ./niri
    ./noctalia
    ./programs

    ./packages.nix
    ./style.nix
    ./xdg-config.nix
  ];

  services.gnome-keyring = {
    enable = true;
    components = [
      "pkcs11"
      "secrets"
      "ssh"
    ];
  };

  dconf.settings = {
    # required to force setting and overwrite multiple others
    "org/gnome/desktop/interface" = {
      color-scheme = lib.mkForce "prefer-dark";
    };
    # remove all window buttons
    "org/gnome/desktop/wm/preferences" = {
      button-layout = lib.mkForce ":";
    };
    # set nautilus terminal
    "com/github/stunkymonkey/nautilus-open-any-terminal" = {
      terminal = "kitty";
    };
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
  };

  # weather daemon
  systemd.user.services.formatted-weather = {
    Unit = {
      Description = "Update cached formatted weather";
      After = [ "network-online.target" ];
    };
    Service = {
      ExecStart = "${formattedWeather}";
      Restart = "on-failure";
      # dependencies
      Environment = "PATH=${
        lib.makeBinPath [
          pkgs.curl
          pkgs.gawk
          pkgs.coreutils
        ]
      }";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # disable niri selecting polkit agent
  systemd.user.services."niri-flake-polkit" = {
    Unit = {
      Description = "Disabled Niri Polkit Agent (replaced by Noctalia)";
    };
    Install = {
      WantedBy = lib.mkForce [ ];
    };
    Service = {
      ExecStart = lib.mkForce "${pkgs.coreutils}/bin/true";
    };
  };

  # systemd.user.services."niri-flake-polkit".enable = false;
}
