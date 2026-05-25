/*
users.nix

part of nixos system
created 2026-04-22 by ludw
*/
let
  accounts = import ./accounts.nix;

  ludwig-radicale = pkgs: {
    primary = true;

    remote = {
      type = "caldav";
      url = "https://dav.home.lan/ludwig/5e65e2ab-2d54-5561-9310-3a7420d54388/";
      userName = "ludwig";
    };

    vdirsyncer = {
      enable = true;
      collections = ["from a" "from b"];
      metadata = ["color" "displayname"];
    };
  };
in {
  ludw = {
    session = "nn";

    email = "ludwig.geyer@mailbox.org";
    fullName = "Ludwig";
    gitName = "cooukiez";
    gitEmail = "ludwig-geyer@web.de";
    name = "ludw";

    sshPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHFFrZLZVIUZBYTGX5gRONHPEv+5QAhq8i6Rm9wHeasK";

    avatar = "ludw.jpg";

    accounts = {
      ludwig-mailbox = accounts.ludwig-mailbox;
      ludwig-web = accounts.ludwig-web;
      web = accounts.web;
    };

    calendar = {
      ludwig-radicale = ludwig-radicale;
    };

    packages = pkgs: with pkgs; [];

    bindDirs = {
      "Documents" = "/data/documents";
      "Downloads" = "/data/downloads";
      "Music" = "/data/music";
      "Pictures" = "/data/pictures";
      "Videos" = "/data/videos";

      "Vault" = "/data/vault";
    };

    passwordManagers = [
      "bitwarden"
    ];

    zenBrowserShortcuts = {
      youtube = "https://www.youtube.com/";
      chatgpt = "https://chatgpt.com/";
      maps = "https://www.google.com/maps";
    };
  };

  ceirs = {
    session = "nn";

    email = "ludwig.geyer@mailbox.org";
    fullName = "Ludwig";
    gitName = "cooukiez";
    gitEmail = "ludwig-geyer@web.de";
    name = "ceirs";

    sshPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDTfSJByS/+4vIn4AMZMjy2ehWfHFDnSq2WXzMDZnXDk";

    avatar = "ceirs.jpg";

    accounts = {
      ludwig-mailbox = accounts.ludwig-mailbox;
      ludwig-web = accounts.ludwig-web;
      web = accounts.web;
    };

    calendar = {
      ludwig-radicale = ludwig-radicale;
    };

    packages = pkgs: with pkgs; [];

    bindDirs = {
      "Documents" = "/data/documents";
      "Downloads" = "/data/downloads";
      "Music" = "/data/music";
      "Pictures" = "/data/pictures";
      "Videos" = "/data/videos";

      "Vault" = "/data/vault";
    };

    passwordManagers = [
      "bitwarden"
    ];

    zenBrowserShortcuts = {
      youtube = "https://www.youtube.com/";
      chatgpt = "https://chatgpt.com/";
      maps = "https://www.google.com/maps";
    };
  };

  redi = {
    session = "nn";

    email = "ludwig@redi-school.org";
    fullName = "Ludwig";
    gitName = "cooukiez";
    gitEmail = "ludwig-geyer@web.de";
    name = "redi";

    sshPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGe437tVoIrqmV1UzVBObyvsr+pNJ6Gp+UgQtWx6frpV";

    avatar = "redi.jpg";

    accounts = {
      ludwig-mailbox = accounts.ludwig-mailbox;
      web = accounts.web;
    };

    calendar = {
      ludwig-radicale = ludwig-radicale;
    };

    packages = pkgs:
      with pkgs; [
        asana-pwa
        gamemaker
      ];

    bindDirs = {
      "Documents" = "/data/documents";
      "Downloads" = "/data/downloads";
      "Music" = "/data/music";
      "Pictures" = "/data/pictures";
      "Videos" = "/data/videos";

      "Vault" = "/data/vault";
    };

    passwordManagers = [
      "bitwarden"
      "passbolt"
    ];

    zenBrowserShortcuts = {
      asana = "https://app.asana.com/1/955672552271708/project/1210867499376597/board/1210867499376611";
      personio = "https://redi-school-of-digital-integration.app.personio.com/my-desk";
      google-calendar = "https://calendar.google.com/calendar/u/0/r?pli=1";
      chatgpt = "https://chatgpt.com/";
      gemini = "https://gemini.google.com/app";
      gmail = "https://mail.google.com/mail/u/0/#inbox";
    };
  };
}
