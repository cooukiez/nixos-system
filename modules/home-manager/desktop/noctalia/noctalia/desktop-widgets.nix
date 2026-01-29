/*
  modules/home-manager/desktop/noctalia/noctalia/desktop-widgets.nix

  created by ludw
  on 2026-01-27
*/

{
  enabled = true;
  gridSnap = false;

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
