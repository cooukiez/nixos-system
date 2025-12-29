{
  imports = [
    ./display.nix
    ./hardware.nix
  ];
  
  # enable firmware update services
  services.fwupd.enable = true;

  # system packages
  environment.systemPackages =
    (config.environment.systemPackages or [])
    ++ (with pkgs; [
      vim
      wget
      git
    ]);
}