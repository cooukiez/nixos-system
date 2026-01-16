{ pkgs, userConfig, ... }:
{
  programs.vscode = {
    enable = true;

    settings = {
      "window.titleBarStyle" = "custom";
    };

    userSettings = {
      "editor.insertSpaces" = true;
      "editor.tabSize" = 2;
      "editor.detectIndentation" = false;

      "editor.formatOnSave" = true;
    };
  };
}