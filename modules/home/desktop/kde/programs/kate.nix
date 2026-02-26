/*
  modules/home/desktop/kde/programs/kate.nix

  created by ludw
  on 2026-02-23
*/

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
