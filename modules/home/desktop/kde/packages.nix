{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.desktop.kde;

  breezeChameleonDark = pkgs.fetchzip {
    url = "https://github.com/cooukiez/breeze-chameleon-dark-upstream/releases/download/latest/Breeze-Chameleon-Dark.tar.xz";
    sha256 = "sha256-18d1HcluLQbMcigaGn5tG01xzTug5sNyGZawot0zrG8=";
  };
in
{
  config = lib.mkIf cfg {
    home.file.".local/share/icons/Breeze-Chameleon-Dark" = {
      source = breezeChameleonDark;
      recursive = true;
    };

    home.packages = with pkgs; [
      kde-rounded-corners
      kdePackages.krohnkite
    ];
  };
}
