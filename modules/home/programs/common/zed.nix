{
  pkgs,
  ...
}:
{
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-latest;

    extensions = [
      "nix"
      "rust"
      "toml"
    ];

    userSettings = {
      theme = {
        mode = "system";
        dark = "One Dark";
        light = "One Light";
      };

      features = {
        copilot = false;
      };

      telemetry = {
        metrics = false;
      };

      hour_format = "hour24";

      ui_font_size = 16;
      buffer_font_size = 16;

      vim_mode = false;
    };
  };
}
