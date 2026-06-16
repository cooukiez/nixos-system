/*
hosts/lvl/hardware-generated.nix

part of nixos system
created 2026-02-26 by ludw
*/
{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usb_storage"
    "sd_mod"
  ];

  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = lib.mkForce "/dev/mapper/cryptroot";
    fsType = "btrfs";
    options = ["subvol=root"];
  };

  boot.initrd.luks.devices."cryptroot".device = lib.mkForce "/dev/disk/by-uuid/3dce443d-10a2-4566-89b0-9b7472177c82";

  fileSystems."/boot" = {
    device = lib.mkForce "/dev/disk/by-uuid/52F3-9803";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  fileSystems."/data" = {
    device = lib.mkForce "/dev/mapper/cryptroot";
    fsType = "btrfs";
    options = ["subvol=data"];
  };

  fileSystems."/home" = {
    device = lib.mkForce "/dev/mapper/cryptroot";
    fsType = "btrfs";
    options = ["subvol=home"];
  };

  fileSystems."/nix" = {
    device = lib.mkForce "/dev/mapper/cryptroot";
    fsType = "btrfs";
    options = ["subvol=nix"];
  };

  fileSystems."/var" = {
    device = lib.mkForce "/dev/mapper/cryptroot";
    fsType = "btrfs";
    options = ["subvol=var"];
  };

  swapDevices = [
    {device = lib.mkForce "/dev/disk/by-uuid/46974f44-fd2a-4c6d-9432-f00266704b4a";}
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
