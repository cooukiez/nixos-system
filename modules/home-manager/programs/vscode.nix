{ pkgs, userConfig, ... }:
{
  programs.vscode = {
    enable = true;

    profiles.default = {
      userSettings = {
        "window.titleBarStyle" = "custom";
        "window.controlsStyle" = "hidden";

        "editor.insertSpaces" = true;
        "editor.tabSize" = 2;
        "editor.detectIndentation" = false;

        "editor.formatOnSave" = true;
      };
    };
  };
}