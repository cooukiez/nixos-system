{
  stdenv,
  lib,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "mcmojave-cursors";
  version = "none";

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = "McMojave-cursors";
    rev = "master";
    sha256 = "sha256-4YqSucpxA7jsuJ9aADjJfKRPgPR89oq2l0T1N28+GV0=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons/McMojave-cursors
    cp -pr dist/* $out/share/icons/McMojave-cursors/

    runHook postInstall
  '';

  meta = with lib; {
    description = "McMojave GTK cursor theme";
    homepage = "https://github.com/vinceliuice/McMojave-cursors";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
