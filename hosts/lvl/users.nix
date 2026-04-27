/*
  user-configuration.nix

  created by ludw
  on 2026-02-26
*/

{
  ceirs = {
    session = "nn";

    email = "ludwig.geyer@mailbox.org";
    fullName = "Ludwig";
    gitName = "cooukiez";
    gitEmail = "ludwig-geyer@web.de";
    name = "ceirs";

    avatar = ../../files/avatar/ceirs.jpg;

    bindDirs = {
      "Documents" = "/data/documents";
      "Downloads" = "/data/downloads";
      "Music" = "/data/music";
      "Pictures" = "/data/pictures";
      "Videos" = "/data/videos";
    };

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

    avatar = ../../files/avatar/redi.jpg;

    bindDirs = {
      "Documents" = "/data/documents/work/redi";
      "Downloads" = "/data/downloads";
      "Music" = "/data/music";
      "Pictures" = "/data/documents/work/redi/pictures";
      "Videos" = "/data/documents/work/redi/videos";
    };

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
