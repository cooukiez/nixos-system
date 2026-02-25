{
  config,
  lib,
  ...
}:
let
  primaryMonitor = "eDP-1";
  displayScale = 2;
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
        # Time
        {
          monitor = primaryMonitor;

          text = ''cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"'';
          color = "rgba(216, 222, 233, 0.7)";

          font_size = 160 * displayScale;
          font_family = "steelfish outline regular";

          position = "${toString (0 * displayScale)}, ${toString (370 * displayScale)}";
          halign = "center";
          valign = "center";
        }
        # Day-Month-Date
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
        # USER
        {
          monitor = primaryMonitor;

          text = "Welcome back, $USER!";
          color = "rgba(216, 222, 233, 0.80)";

          font_size = 18 * displayScale;
          font_family = "SF Pro Display Bold";

          position = "${toString (0 * displayScale)}, ${toString (-180 * displayScale)}";
          halign = "center";
          valign = "center";
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
