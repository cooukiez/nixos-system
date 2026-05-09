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
  // lib.optionalAttrs (config.desktop.kde or false) {
    pinentry.package = pkgs.kwalletcli;
    pinentry.program = "${pkgs.kwalletcli}/bin/pinentry-kwallet";
  }
  // lib.optionalAttrs (config.desktop.nn or false) {
    pinentry.package = pkgs.pinentry-gnome3;
  };

  age.secrets.gpg-primary = {
    file = ../../secrets/gpg-secret.age;
    path = "${config.home.homeDirectory}/.gnupg/imported-key.asc";
  };

  age.secrets.gpg-public = {
    file = ../../secrets/gpg-public.age;
    path = "${config.home.homeDirectory}/.gnupg/public-key.asc";
  };

  home.activation = {
    importGpgKeys = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      export GNUPGHOME="${config.programs.gpg.homedir}"

      if [ ! -d "$GNUPGHOME" ]; then
        mkdir -p "$GNUPGHOME"
        chmod 700 "$GNUPGHOME"
      fi

      if [ -f "${config.age.secrets.gpg-primary.path}" ]; then
        echo "Importing private GPG key..."
        ${lib.getExe pkgs.gnupg} --batch --import "${config.age.secrets.gpg-primary.path}"
        rm -f "${config.age.secrets.gpg-primary.path}"
      fi

      if [ -f "${config.age.secrets.gpg-public.path}" ]; then
        echo "Importing public GPG key..."
        ${lib.getExe pkgs.gnupg} --batch --import "${config.age.secrets.gpg-public.path}"
        rm -f "${config.age.secrets.gpg-public.path}"
      fi

      ${pkgs.gnupg}/bin/gpg --list-secret-keys --with-colons | \
        grep '^fpr' | cut -d: -f10 | \
        xargs -I {} echo "{}:6:" | \
        ${lib.getExe pkgs.gnupg} --batch --import-ownertrust || true
    '';
  };
}
