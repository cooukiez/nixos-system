/*
modules/home/desktop/nn/noctalia/desktop-widgets.nix

part of nixos system
created 2026-06-16 by ludw
*/
{
  enabled = false;
  overviewEnabled = true;

  gridSnap = false;
  gridSnapScale = false;

  monitorWidgets = [
    {
      name = "eDP-1";
      widgets = [
        {
          id = "Weather";
          scale = 0.995;
          showBackground = true;
          x = 200;
          y = 180;
        }
        {
          id = "MediaPlayer";
          hideMode = "visible";

          roundedCorners = true;
          showAlbumArt = true;
          showBackground = true;
          showButtons = true;
          showVisualizer = true;
          visualizerType = "linear";

          x = 40;
          y = 85;
        }
        {
          id = "Clock";
          clockStyle = "digital";
          format = "HH:mm\\nd MMMM yyyy";

          roundedCorners = true;
          showBackground = true;

          x = 40;
          y = 180;
        }
      ];
    }
  ];
}
