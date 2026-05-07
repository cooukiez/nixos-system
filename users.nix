/*
  hosts/lvl/users.nix

  created by ludw
  on 2026-04-22
*/

let
  accounts = import ./accounts.nix;
in
{
  ludw = {
    session = "nn";

    email = "ludwig.geyer@mailbox.org";
    fullName = "Ludwig";
    gitName = "cooukiez";
    gitEmail = "ludwig-geyer@web.de";
    name = "ludw";

    avatar = "ludw.jpg";

    accounts = {
      Mailbox = accounts.ludwigMailbox;
      Old = accounts.ludwigWeb;
      Web = accounts.webAccount;
    };

    packages = pkgs: with pkgs; [ ];

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

    avatar = "ceirs.jpg";

    accounts = {
      Mailbox = accounts.ludwigMailbox;
      Old = accounts.ludwigWeb;
      Web = accounts.webAccount;
    };

    packages = pkgs: with pkgs; [ ];

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

    avatar = "redi.jpg";

    accounts = {
      Mailbox = accounts.ludwigMailbox;
      Web = accounts.webAccount;
    };

    packages =
      pkgs: with pkgs; [
        asana-pwa
      ];

    bindDirs = {
      "Documents" = "/data/documents/work/redi";
      "Downloads" = "/data/downloads";
      "Music" = "/data/music";
      "Pictures" = "/data/documents/work/redi/pictures";
      "Videos" = "/data/documents/work/redi/videos";

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
