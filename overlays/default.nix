# file defines overlays
{inputs, ...}: {
  # this one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;
  
  # this one contains whatever you want to overlay
  # change versions, add patches, set compilation flags, anything really
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };

  # when applied, the unstable nixpkgs set (declared in the flake inputs)
  # will be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}