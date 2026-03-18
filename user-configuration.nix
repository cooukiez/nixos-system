/*
  user-configuration.nix

  created by ludw
  on 2026-02-26
*/

{
  ceirs = {
    email = "ludwig.geyer@mailbox.org";
    fullName = "Ceirs";
    githubName = "cooukiez";
    githubEmail = "ludwig-geyer@web.de";
    name = "ceirs";

    avatar = ./files/avatar/ceirs.jpg;

    bindDirs = [
      {
        source = "/data/documents";
        target = "Documents";
      }
      {
        source = "/data/downloads";
        target = "Downloads";
      }
      {
        source = "/data/music";
        target = "Music";
      }
      {
        source = "/data/pictures";
        target = "Pictures";
      }
      {
        source = "/data/videos";
        target = "Videos";
      }
    ];

    zenBrowserShortcuts = {
      youtube = {
        url = "https://www.youtube.com/";
        position = 101;
      };
      chatgpt = {
        url = "https://chatgpt.com/";
        position = 102;
      };
      maps = {
        url = "https://www.google.com/maps";
        position = 103;
      };
    };
  };

  ludw = {
    email = "ludwig.geyer@mailbox.org";
    fullName = "Ludwig";
    githubName = "cooukiez";
    githubEmail = "ludwig-geyer@web.de";
    name = "ludw";

    avatar = ./files/avatar/ludw.jpg;

    bindDirs = [
      {
        source = "/data/documents";
        target = "Documents";
      }
      {
        source = "/data/downloads";
        target = "Downloads";
      }
      {
        source = "/data/music";
        target = "Music";
      }
      {
        source = "/data/pictures";
        target = "Pictures";
      }
      {
        source = "/data/videos";
        target = "Videos";
      }
    ];

    zenBrowserShortcuts = {
      youtube = {
        url = "https://www.youtube.com/";
        position = 101;
      };
      chatgpt = {
        url = "https://chatgpt.com/";
        position = 102;
      };
      maps = {
        url = "https://www.google.com/maps";
        position = 103;
      };
    };
  };

  redi = {
    email = "ludwig@redi-school.org";
    fullName = "Ludwig";
    githubName = "cooukiez";
    githubEmail = "ludwig-geyer@web.de";
    name = "redi";

    avatar = ./files/avatar/redi.jpg;

    bindDirs = [
      {
        source = "/data/documents/work/redi";
        target = "Documents";
      }
      {
        source = "/data/downloads";
        target = "Downloads";
      }
      {
        source = "/data/music";
        target = "Music";
      }
      {
        source = "/data/documents/work/redi/pictures";
        target = "Pictures";
      }
      {
        source = "/data/documents/work/redi/videos";
        target = "Videos";
      }
    ];

    zenBrowserShortcuts = {
      asana = {
        url = "https://app.asana.com/1/955672552271708/project/1210867499376597/board/1210867499376611";
        position = 101;
      };
      personio = {
        url = "https://redi-school-of-digital-integration.app.personio.com/my-desk";
        position = 102;
      };
      google-calendar = {
        url = "https://calendar.google.com/calendar/u/0/r?pli=1";
        position = 103;
      };
      chatgpt = {
        url = "https://chatgpt.com/";
        position = 104;
      };
      gemini = {
        url = "https://gemini.google.com/app";
        position = 105;
      };
      gmail = {
        url = "https://mail.google.com/mail/u/0/#inbox";
        position = 106;
      };
    };
  };
}
