{ pkgs, ... }: {
  imports = [
    ./display.nix
    ./hardware.nix
  ];
  
  # enable firmware update services
  services.fwupd.enable = true;

  # system packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git

    home-manager
  ];
}
