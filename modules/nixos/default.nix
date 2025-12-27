# add reusable nixos modules to this directory, on their own file (https://nixos.wiki/wiki/Module)
# these should be stuff you would like to share with others, not your personal configurations
{
  # list your module files here
  imports = [
    ./common.nix

    ./base/bluetooth.nix
    ./base/graphics.nix
    ./base/network.nix
    ./base/sound.nix

    ./desktop/kde.nix
  ];
}