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
{
  imports = [
    ./file-explorers.nix
    ./media.nix
    ./network-services.nix
    ./penetration-testing.nix
    ./services.nix
    ./web.nix
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/etc/nixos"; # sets NH_OS_FLAKE variable for you
  };

  # SUID wrappers
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # enable flatpak and install apps from flathub
  services.flatpak = {
    enable = true;
    remotes = [
      {
        name = "flathub";
        location = "https://flathub.org/repo/flathub.flatpakrepo";
      }
    ];

    # declare packages declaratively
    services.flatpak.packages = [
      "com.github.vikdevelop.photopea_app"
      "com.leinardi.gst"
      "be.alexandervanhee.gradia"
      "edu.mit.Scratch"
      "org.turbowarp.TurboWarp"
    ];

    services.flatpak.update.onActivation = true;
  };

  # running gnome apps outside of gnome
  programs.dconf.enable = true;
  services.gvfs.enable = true;

  # enable zsh as shell
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    hardinfo2
    pavucontrol
    gimp-with-plugins
    krita
    inkscape
    icon-slicer
    bluez-tools
    homebank
    hardcode-tray
    renderdoc
    github-desktop
    intel-gpu-tools
    furmark
    firestarter
    geekbench
    affine
    bitwarden-desktop
    bitwarden-cli
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    meld
    gephi

    # code editors / IDE
    jetbrains.rust-rover
    jetbrains.webstorm
    jetbrains.pycharm
    jetbrains.phpstorm
    jetbrains.idea
    jetbrains.clion
    jetbrains-toolbox
    vscode

    # wine compatibilty
    wineWowPackages.stable
    winetricks
    wineWowPackages.waylandFull

    # from flakes
    inputs.honklet.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # enalbe nvim console editor
  programs.neovim.enable = true;
}
