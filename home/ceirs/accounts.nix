/*
  home/ceirs/accounts.nix

  created by ludw
  on 2026-02-23
*/

{
  accounts.email.accounts = {
    ludwigMailbox = {
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

    ludwigWeb = {
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

    webAccount = {
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
  };
}
