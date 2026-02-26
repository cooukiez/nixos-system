/*
  user-configuration.nix

  created by ludw
  on 2026-02-23
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
  };
}
