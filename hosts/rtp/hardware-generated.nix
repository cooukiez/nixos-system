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
    "nvme"
    "usb_storage"
    "sd_mod"
  ];

  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = lib.mkForce "/dev/disk/by-uuid/47ae29a9-f04a-460e-9159-6eda50cbf45e";
    fsType = "btrfs";
    options = ["subvol=root"];
  };

  fileSystems."/boot" = {
    device = lib.mkForce "/dev/disk/by-uuid/AA59-D168";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  fileSystems."/data" = {
    device = lib.mkForce "/dev/disk/by-uuid/47ae29a9-f04a-460e-9159-6eda50cbf45e";
    fsType = "btrfs";
    options = ["subvol=data"];
  };

  fileSystems."/home" = {
    device = lib.mkForce "/dev/disk/by-uuid/47ae29a9-f04a-460e-9159-6eda50cbf45e";
    fsType = "btrfs";
    options = ["subvol=home"];
  };

  fileSystems."/nix" = {
    device = lib.mkForce "/dev/disk/by-uuid/47ae29a9-f04a-460e-9159-6eda50cbf45e";
    fsType = "btrfs";
    options = ["subvol=nix"];
  };

  fileSystems."/var" = {
    device = lib.mkForce "/dev/disk/by-uuid/47ae29a9-f04a-460e-9159-6eda50cbf45e";
    fsType = "btrfs";
    options = ["subvol=var"];
  };

  swapDevices = [
    {device = lib.mkForce "/dev/disk/by-uuid/690b5019-ca45-4e7a-97f8-cc2845feec22";}
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
