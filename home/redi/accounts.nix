{
  accounts.email.accounts = {
    ludwig = {
      enable = true;
      primary = true;
      address = "ludwig@redi-school.org";
      userName = "ludwig@redi-school.org";

      /*
        imap = {
          host = "imap.gmail.com";
          port = 993;
          tls.enable = true;
        };

        smtp = {
          host = "smtp.gmail.com";
          port = 587;
          tls = {
            enable = true;
            useStartTls = true;
          };
        };
      */

      # name = "ludwig";
      realName = "Ludwig";

      thunderbird.enable = true;
      thunderbird.profiles = [ "default" ];
    };

    kids = {
      enable = true;
      address = "kids@redi-school.org";
      userName = "kids@redi-school.org";

      /*
        imap = {
          host = "imap.gmail.com";
          port = 993;
          tls.enable = true;
        };

        smtp = {
          host = "smtp.gmail.com";
          port = 587;
          tls = {
            enable = true;
            useStartTls = true;
          };
        };
      */

      # name = "kids";
      realName = "Kids";

      thunderbird.enable = true;
      thunderbird.profiles = [ "default" ];
    };

    cookiecenter = {
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

      # name = "cookiecenter";
      realName = "Web Account";

      thunderbird.enable = true;
      thunderbird.profiles = [ "default" ];
    };
  };
}
