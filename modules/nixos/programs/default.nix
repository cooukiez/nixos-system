/*
  modules/nixos/programs/default.nix

  created by ludw
  on 2026-01-25
*/

{
  pkgs,
  inputs,
  ...
}:
let
  # fix this and put in nautilus extensions
  _nautilusBackspaceSrc = pkgs.fetchFromGitHub {
    owner = "TheWeirdDev";
    repo = "nautilus-backspace";
    rev = "main";
    sha256 = "sha256-4x5bMIgwNIp9nxuCHWLLNvWG2zuviyEOyCZgVLRZ5W4=";
  };
in
{
  imports = [
    ./network-services.nix
    ./penetration-testing.nix
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/etc/nixos"; # sets NH_OS_FLAKE variable for you
  };

  # running gnome apps outside of gnome
  programs.dconf.enable = true;
  services.gvfs.enable = true;

  # SUID wrappers
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.flatpak.enable = true;
  systemd.services.flatpak-flathub = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

      flatpak install -y --system flathub com.github.vikdevelop.photopea_app
      flatpak install -y --system flathub com.leinardi.gst
      flatpak install -y --system flathub be.alexandervanhee.gradia
      flatpak install -y --system flathub edu.mit.Scratch
      flatpak install -y --system flathub org.turbowarp.TurboWarp
    '';
  };

  environment.systemPackages = with pkgs; [
    hardinfo2
    pavucontrol
    gimp-with-plugins
    krita
    inkscape
    icon-slicer
    google-chrome
    bluez-tools
    homebank
    discord
    legcord
    hardcode-tray
    renderdoc
    github-desktop
    vscode
    qbittorrent-enhanced
    qbittorrent-cli
    intel-gpu-tools
    furmark
    firestarter
    geekbench
    affine
    bitwarden-desktop
    bitwarden-cli
    gpu-screen-recorder
    jetbrains.rust-rover
    jetbrains.webstorm
    jetbrains.pycharm
    jetbrains.phpstorm
    jetbrains.idea
    jetbrains.clion
    jetbrains-toolbox
    gpu-screen-recorder-gtk
    meld
    signal-desktop
    gephi

    # from flakes
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.twilight
    inputs.honklet.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.neovim.enable = true;
}
