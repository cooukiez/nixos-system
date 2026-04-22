/*
  configuration.nix

  created by ludw
  on 2026-02-26
*/

# system configuration file

{
  inputs,
  config,
  pkgs,
  lib,
  hostname,
  dnsServers,
  users,
  ...
}:
{

  # user configuration
  users.users = lib.mapAttrs (_: user: {
    description = user.fullName;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "tailscale"
      "audio"
      "video"
      "input"
      "docker"
      "cdrom"
      "optical"
    ];
    password = "CHANGE-ME";
    shell = pkgs.zsh;
  }) users;

  systemd.tmpfiles.rules = lib.concatLists (
    lib.mapAttrsToList (
      username: user:
      lib.concatLists (
        map (bind: [
          "r /home/${username}/${bind.target}"
          "L /home/${username}/${bind.target} - - - - ${bind.source}"
        ]) (user.bindDirs or [ ])
      )
    ) users
  );

  # see https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.11";
}
