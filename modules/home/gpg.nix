{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.gpg = {
    enable = true;
    homedir = "${config.home.homeDirectory}/.gnupg";
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    defaultCacheTtl = 3600;
  }
  // lib.optionals config.desktop.kde {
    pinentry.package = pkgs.kwalletcli;
    pinentry.program = "${pkgs.kwalletcli}/bin/pinentry-kwallet";
  }
  // lib.optionals config.desktop.nn {
    pinentry.package = pkgs.pinentry-gnome3;
  };

  age.secrets.gpg-primary = {
    file = ../../secrets/gpg-primary.age;
    path = "${config.home.homeDirectory}/.gnupg/imported-key.asc";
  };

  home.activation = {
    importGpgKeys = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      if [ -f "${config.age.secrets.gpg-primary.path}" ]; then
        $DRY_RUN_CMD ${pkgs.gnupg}/bin/gpg --batch --import "${config.age.secrets.gpg-primary.path}"
      fi
    '';
  };
}
