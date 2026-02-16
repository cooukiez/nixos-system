/*
  modules/home/programs/web/default.nix

  created by ludw
  on 2026-01-29
*/

{
  imports = [
    ./webapps

    ./chrome.nix
    ./firefox.nix
    ./thunderbird.nix
    ./zen-browser.nix
  ];
}
