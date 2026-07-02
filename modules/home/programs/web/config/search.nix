/*
modules/home/programs/web/config/search.nix

part of nixos system
created 2026-06-16 by ludw
*/
{pkgs, ...}: {
  force = true;
  default = "ddg";
  privateDefault = "ddg";

  order = [
    "ddg"
    "google"
  ];

  engines = {
    ddg = {
      name = "DuckDuckGo";
      urls = [
        {
          template = "https://duckduckgo.com/?q={searchTerms}";
        }
      ];

      icon = "https://duckduckgo.com/favicon.ico";
      definedAliases = ["@ddg"];
    };

    nix-packages = {
      name = "Nix Packages";
      urls = [
        {
          template = "https://search.nixos.org/packages";
          params = [
            {
              name = "type";
              value = "packages";
            }
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];

      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = ["@np"];
    };

    mynixos = {
      name = "MyNixOS";
      urls = [
        {
          template = "https://mynixos.com/search?q={searchTerms}";
        }
      ];

      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = ["@mn"];
    };

    nixos-wiki = {
      name = "NixOS Wiki";
      urls = [
        {
          template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
        }
      ];

      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = ["@nw"];
    };

    youtube = {
      name = "YouTube";
      urls = [
        {
          template = "https://www.youtube.com/results?search_query={searchTerms}";
        }
      ];

      icon = "https://www.youtube.com/favicon.ico";
      definedAliases = ["@yt"];
    };

    google.metaData.hidden = true;
    bing.metaData.hidden = true;
    ecosia.metaData.hidden = true;
    perplexity.metaData.hidden = true;
  };
}
