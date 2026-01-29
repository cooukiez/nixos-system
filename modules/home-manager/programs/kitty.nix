/*
  modules/home-manager/programs/kitty.nix

  created by ludw
  on 2026-01-29
*/

{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono NF";
      size = 10.0;
    };

    settings = {
      # selection colors
      selection_foreground = "#ebdbb2";
      selection_background = "#d65d0e";

      # window border colors
      active_border_color = "#8ec07c";
      inactive_border_color = "#665c54";

      # tab colors
      active_tab_foreground = "#ebdbb2";
      active_tab_background = "#458588";
      inactive_tab_foreground = "#ebdbb2";
      inactive_tab_background = "#8ec07c";

      # basic colors
      background = "#1d2021";
      foreground = "#ebdbb2";

      # 16 colors
      color0 = "#3c3836";
      color1 = "#cc241d";
      color2 = "#98971a";
      color3 = "#d79921";
      color4 = "#458588";
      color5 = "#b16286";
      color6 = "#689d6a";
      color7 = "#a89984";
      color8 = "#928374";
      color9 = "#fb4934";
      color10 = "#b8bb26";
      color11 = "#fabd2f";
      color12 = "#83a598";
      color13 = "#d3869b";
      color14 = "#8ec07c";
      color15 = "#fbf1c7";

      # cursor
      cursor = "#bdae93";
      cursor_text_color = "#665c54";
      cursor_shape = "block";
      cursor_blink_interval = 0;
      cursor_stop_blinking_after = 0;
      shell_integration = "no-cursor";

      # url
      url_color = "#458588";

      # opacity and blur
      background_opacity = "1.0";
      background_blur = 0;

      # terminal
      term = "xterm-kitty";
      enable_audio_bell = "no";
      linux_display_server = "wayland";

      # scrollback
      scrollback_lines = 5000;
      wheel_scroll_multiplier = "5.0";

      # mouse
      mouse_hiye_wait = -1;

      # window layout
      remember_window_size = "no";
      initial_window_width = 1200;
      initial_window_height = 750;
      window_border_width = "0pt";
      enabled_layouts = "tall";
      window_padding_width = 0;
      window_margin_width = 2;
      hide_window_decorations = "no";

      # tab bar
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_bar_edge = "bottom";
      tab_bar_align = "left";
      active_tab_font_style = "bold";
      inactive_tab_font_style = "normal";

      # testing
      confirm_close = "no";
      allow_remote_control = "yes";
    };

    keybindings = {
      "ctrl+shift+backspace" = "clear_terminal reset active";

      # window management
      "ctrl+shift+enter" = "new_window";
      "ctrl+shift+." = "next_window";
      "ctrl+shift+," = "previous_window";

      # layout management
      "ctrl+shift+l" = "next_layout";
      "ctrl+alt+r" = "goto_layout tall";
      "ctrl+alt+s" = "goto_layout stack";

      # tab management
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+right" = "next_tab";
      "ctrl+shift+left" = "previous_tab";
      "ctrl+shift+q" = "close_tab";
    };

    extraConfig = ''
      map kitty@zsh set-option confirm_close no
    '';
  };
}
