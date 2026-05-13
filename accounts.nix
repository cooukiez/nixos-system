/*
  accounts.nix

  part of nixos system
  created 2026-04-22 by ludw
*/

{
  ludwig-mailbox = {
    enable = true;
    primary = true;

    address = "ludwig.geyer@mailbox.org";
    userName = "ludwig.geyer@mailbox.org";

    imap = {
      host = "imap.mailbox.org";
      port = 993;
      tls.enable = true;
    };

    smtp = {
      host = "smtp.mailbox.org";
      port = 587;
      tls = {
        enable = true;
        useStartTls = true;
      };
    };

    realName = "Ludwig Geyer";

    thunderbird.enable = true;
    thunderbird.profiles = [ "default" ];
  };

  ludwig-web = {
    enable = true;

    address = "ludwig-geyer@web.de";
    userName = "ludwig-geyer@web.de";

    imap = {
      host = "imap.web.de";
      port = 993;
      tls.enable = true;
    };

    smtp = {
      host = "smtp.web.de";
      port = 587;
      tls = {
        enable = true;
        useStartTls = true;
      };
    };

    realName = "Ludwig";

    thunderbird.enable = true;
    thunderbird.profiles = [ "default" ];
  };

  web = {
    enable = true;
    address = "cookiecenter@web.de";
    userName = "cookiecenter@web.de";

    imap = {
      host = "imap.web.de";
      port = 993;
      tls.enable = true;
    };

    smtp = {
      host = "smtp.web.de";
      port = 587;
      tls = {
        enable = true;
        useStartTls = true;
      };
    };

    realName = "Web Account";

    thunderbird.enable = true;
    thunderbird.profiles = [ "default" ];
  };
}
