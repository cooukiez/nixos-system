{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./niri.nix
    ./noctalia.nix
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

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
  };
}
