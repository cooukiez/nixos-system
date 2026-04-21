{
  lib,
  stdenv,
  fetchFromGitHub,
  buildNpmPackage,
  electron,
  copyDesktopItems,
  makeDesktopItem,
  python3,
}:

buildNpmPackage rec {
  pname = "scratch-desktop";
  version = "3.30.5";

  src = fetchFromGitHub {
    owner = "scratchfoundation";
    repo = "scratch-desktop";
    rev = "v${version}";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Replace with actual hash
  };

  # This is the hash for the npm dependencies.
  # Set to lib.fakeHash initially, then update after first build attempt.
  npmDepsHash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";

  nativeBuildInputs = [
    copyDesktopItems
    python3 # Often required by node-gyp for native modules
  ];

  # The 'fetch' script in package.json downloads the media library.
  # We run it during the build process so assets are bundled.
  preBuild = ''
    npm run fetch
  '';

  # We use the 'compile' and 'build:dir' tasks.
  # We don't want 'dist' because it tries to create a .deb or .rpm,
  # which we don't need since Nix handles the installation.
  npmBuildScript = "build:dir";

  installPhase = ''
    runHook preInstall

    # The build:dir script puts files in dist/linux-unpacked or similar
    mkdir -p $out/opt/scratch-desktop
    cp -r dist/linux-unpacked/* $out/opt/scratch-desktop/

    # Create a wrapper to launch Electron with the app
    mkdir -p $out/bin
    makeWrapper ${electron}/bin/electron $out/bin/scratch-desktop \
      --add-flags $out/opt/scratch-desktop/resources/app.asar

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "scratch-desktop";
      exec = "scratch-desktop";
      icon = "scratch-desktop";
      desktopName = "Scratch 3";
      genericName = "Offline Editor";
      categories = [
        "Education"
        "Development"
      ];
    })
  ];

  meta = with lib; {
    description = "Scratch 3.0 as a self-contained desktop application";
    homepage = "https://scratch.mit.edu/download";
    license = licenses.agpl3Only;
    maintainers = with maintainers; [ ]; # Add your handle here
    platforms = [ "x86_64-linux" ];
  };
}
