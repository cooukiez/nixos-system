{ pkgs, userConfig, ... }:
{
  programs.kate = {
    enable = true;

    editor = {
      brackets.automaticallyAddClosing = true;
      brackets.highlightMatching = true;
      brackets.highlightRangeBetween = true;

      indent.autodetect = false;
      indent.width = 2;
      indent.replaceWithSpaces = true;
      indent.showLines = true;
      tabWidth = 4;
    };
  };
}
