/*
  modules/home/desktop/nn/noctalia/plugins.nix

  created by ludw
  on 2026-02-26
*/

{
  sources = [
    {
      enabled = true;
      name = "Noctalia Plugins";
      url = "https://github.com/noctalia-dev/noctalia-plugins";
    }
  ];

  states = {
    catwalk = {
      enabled = true;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };

    fancy-audiovisualizer = {
      enabled = false;
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
      # not used currently
      enabled = false;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };

    network-manager-vpn = {
      # not used currently
      enabled = false;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };

    polkit-agent = {
      enabled = true;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };

    privacy-indicator = {
      enabled = true;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };

    screen-recorder = {
      # not used currently
      enabled = false;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };

    screen-toolkit = {
      # great but buggy
      enabled = false;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };

    screenshot = {
      # not used currently
      enabled = false;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };

    tailscale = {
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
      # not used currently
      enabled = false;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };

    world-clock = {
      enabled = true;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    };
  };

  version = 1;
}
