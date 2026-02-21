/*
  hardware-configuration.nix

  created by ludw
  on 2026-02-18
*/

# generated config by nixos
# do not modify this file

{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "usb_storage"
    "sd_mod"
  ];

  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/314a17cb-460f-4952-8c92-d41295b63692";
    fsType = "btrfs";
    options = [ "subvol=root" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/5E5A-C092";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/314a17cb-460f-4952-8c92-d41295b63692";
    fsType = "btrfs";
    options = [ "subvol=data" ];
  };
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/314a17cb-460f-4952-8c92-d41295b63692";
    fsType = "btrfs";
    options = [ "subvol=home" ];
  };
  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/314a17cb-460f-4952-8c92-d41295b63692";
    fsType = "btrfs";
    options = [ "subvol=nix" ];
  };
  fileSystems."/var" = {
    device = "/dev/disk/by-uuid/314a17cb-460f-4952-8c92-d41295b63692";
    fsType = "btrfs";
    options = [ "subvol=var" ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/2a3b20f5-7e74-4655-a560-f2c5f045da27"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
