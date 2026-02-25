{
  config,
  pkgs,
  lib,
  ...
}:
let
  primaryMonitor = "eDP-1";
  # 4k display scaling factor
  displayScale = 2;

  songDetails = pkgs.writeShellScript "songdetails.sh" (builtins.readFile ./scripts/songdetails.sh);
  weatherDetails = pkgs.writeShellScript "weatherdetails.sh" (
    builtins.readFile ./scripts/weatherdetails.sh
  );
in
{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
        fractional_scaling = 2;
      };

      auth = {
        fingerprint.enabled = true;
      };

      background = [
        {
          monitor = primaryMonitor;

          path = "${./lockscreen.jpg}";

          blur_passes = 1;

          contrast = 0.8916;
          brightness = 0.8172;

          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      label = [
        # time
        {
          monitor = primaryMonitor;

          text = ''cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"'';
          color = "rgba(216, 222, 233, 0.7)";

          font_size = 185 * displayScale;
          font_family = "steelfish outline regular";

          position = "${toString (0 * displayScale)}, ${toString (340 * displayScale)}";
          halign = "center";
          valign = "center";
        }
        # day-month-date
        {
          monitor = primaryMonitor;

          text = ''cmd[update:1000] echo -e "$(date +"%A, %B %d")"'';
          color = "rgba(216, 222, 233, 0.7)";

          font_size = 28 * displayScale;
          font_family = "SF Pro Display Bold";

          position = "${toString (0 * displayScale)}, ${toString (490 * displayScale)}";
          halign = "center";
          valign = "center";
        }
        # user
        {
          monitor = primaryMonitor;

          text = "Welcome back, $USER!";
          color = "rgba(216, 222, 233, 0.80)";

          font_size = 18 * displayScale;
          font_family = "SF Pro Display Bold";

          position = "${toString (0 * displayScale)}, ${toString (-190 * displayScale)}";
          halign = "center";
          valign = "center";
        }
        # current song
        {
          monitor = primaryMonitor;

          text = ''cmd[update:1000] echo "$(${songDetails})"'';
          color = "rgba(216, 222, 233, 0.80)";

          font_size = 18 * displayScale;
          font_family = "SF Pro Nerd Display Bold";

          position = "0, ${toString (50 * displayScale)}";
          halign = "center";
          valign = "bottom";
        }
        # weather
        {
          monitor = primaryMonitor;

          text = ''cmd[update:1000] echo "$(${weather})"'';
          color = "rgba(216, 222, 233, 0.80)";

          font_size = 18 * displayScale;
          font_family = "SF Pro Nerd Display Bold";

          position = "0, ${toString (100 * displayScale)}";
          halign = "center";
          valign = "bottom";
        }
      ];

      input-field = [
        {
          monitor = primaryMonitor;

          size = "${toString (300 * displayScale)}, ${toString (60 * displayScale)}";

          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;

          outline_thickness = 2;
          outer_color = "rgba(255, 255, 255, 0)";
          inner_color = "rgba(255, 255, 255, 0.1)";
          font_color = "rgb(200, 200, 200)";

          fade_on_empty = false;
          hide_input = false;

          font_family = "SF Pro Display Bold";
          placeholder_text = ''<i><span foreground="##ffffff99">Enter Password</span></i>'';

          position = "${toString (0 * displayScale)}, ${toString (-250 * displayScale)}";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
