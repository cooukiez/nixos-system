/*
  _archive/style-bak.nix

  created by ludw
  on 2026-02-17
*/

{
  /*
    # old base16Scheme
    base16Scheme = {
      base00 = "#131313"; # background (mSurface)
      base01 = "#1f1f1f"; # surface variant
      base02 = "#474747"; # outline
      base03 = "#c6c6c6"; # secondary text / comments
      base04 = "#e2e2e2"; # tertiary text
      base05 = "#e2e2e2"; # default foreground (mOnSurface)
      base06 = "#6e6e6e"; # primary foreground
      base07 = "#6e6e6e"; # bright foreground

      base08 = "#ffb4ab"; # error
      base09 = "#e2e2e2"; # hover / highlight
      base0A = "#c6c6c6"; # secondary
      base0B = "#ffffff"; # primary
      base0C = "#e2e2e2"; # tertiary
      base0D = "#ffffff"; # accent
      base0E = "#c6c6c6"; # secondary accent
      base0F = "#690005"; # error foreground
    };
  */

  home.file.".config/gtk-3.0/gtk-bak.css".text = ''
    @define-color accent_color #6e6e6e;
    @define-color accent_bg_color #6e6e6e;
    @define-color accent_fg_color #1b1b1b;
    @define-color window_bg_color #131313;
    @define-color window_fg_color #e2e2e2;
    @define-color headerbar_bg_color #131313;
    @define-color headerbar_fg_color #e2e2e2;
    @define-color popover_bg_color #474747;
    @define-color popover_fg_color #c6c6c6;
    @define-color view_bg_color #131313;
    @define-color view_fg_color #e2e2e2;
    @define-color card_bg_color #131313;
    @define-color card_fg_color #e2e2e2;

    @define-color sidebar_bg_color #1f1f1f;
    @define-color sidebar_fg_color #e2e2e2;
    @define-color sidebar_border_color @window_bg_color;
    @define-color sidebar_backdrop_color @window_bg_color;
  '';

  home.file.".config/gtk-4.0/gtk-bak.css".text = ''
    @define-color accent_color #6e6e6e;
    @define-color accent_bg_color #6e6e6e;
    @define-color accent_fg_color #1b1b1b;
    @define-color window_bg_color #131313;
    @define-color window_fg_color #e2e2e2;
    @define-color headerbar_bg_color #131313;
    @define-color headerbar_fg_color #e2e2e2;
    @define-color popover_bg_color #474747;
    @define-color popover_fg_color #c6c6c6;
    @define-color view_bg_color #131313;
    @define-color view_fg_color #e2e2e2;
    @define-color card_bg_color #131313;
    @define-color card_fg_color #e2e2e2;

    @define-color sidebar_bg_color #1f1f1f;
    @define-color sidebar_fg_color #e2e2e2;
    @define-color sidebar_border_color @window_bg_color;
    @define-color sidebar_backdrop_color @window_bg_color;
  '';
}
