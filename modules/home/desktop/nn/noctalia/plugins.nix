/*
  modules/home/desktop/nn/noctalia/plugins.nix

  created by ludw
  on 2026-02-17
*/

{
  sources = [
    {
      enabled = true;
      name = "Noctalia Plugins";
      url = "https://github.com/noctalia-dev/noctalia-plugins";
    }
  ];

  # install noctalia plugins here
  states = {
    catwalk = {
      enabled = true;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };
    fancy-audiovisualizer = {
      enabled = true;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };
    kaomoji-provider = {
      enabled = true;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };
    keybind-cheatsheet = {
      enabled = true;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };
    network-indicator = {
      enabled = true;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };
    privacy-indicator = {
      enabled = true;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };
    screen-recorder = {
      enabled = true;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };
    screenshot = {
      enabled = true;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };
    timer = {
      enabled = true;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };
    translator = {
      enabled = true;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };
    update-count = {
      enabled = true;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };
    world-clock = {
      enabled = true;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };
  };

  version = 1;
}
