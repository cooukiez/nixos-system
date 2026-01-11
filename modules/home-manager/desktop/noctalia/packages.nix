{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # packages for noctalia
    kitty
    mission-center
  ];
}
