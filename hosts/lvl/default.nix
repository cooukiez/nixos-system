{
  config,
  inputs,
  pkgs,
  lib,
  userList,
  ...
}:
{
  imports = [
    ./config.nix
    ./hardware-generated.nix
    ./hardware-old.nix

    inputs.agenix.nixosModules.default
  ];

  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages

      (final: prev: {
        valkey = prev.valkey.overrideAttrs (oldAttrs: {
          doCheck = false;
        });
      })
    ];

    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "dotnet-sdk-6.0.428"
        "dotnet-runtime-6.0.36"

        "googleearth-pro-7.3.6.10201"
        "ventoy-1.1.10"
      ];
    };
  };
  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        experimental-features = "nix-command flakes";
        flake-registry = "";
        nix-path = config.nix.nixPath;
      };

      channel.enable = false;

      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

      optimise.automatic = true;
      optimise.dates = [ "03:45" ];
    };

  users.users = lib.mapAttrs (_: user: {
    description = user.fullName;
    isNormalUser = true;
    extraGroups = [
      "wheel"

      "audio"
      "input"
      "video"

      "networkmanager"
      "tailscale"

      "cdrom"
      "optical"
    ];
    password = "CHANGE-ME";
    shell = pkgs.zsh;
  }) userList;

  systemd.tmpfiles.rules = lib.concatLists (
    lib.mapAttrsToList (
      username: user:
      lib.mapAttrsToList (target: source: [
        "r /home/${username}/${target}"
        "L /home/${username}/${target} - - - - ${source}"
      ]) (user.bindDirs or { })
    ) userList
  );
}
