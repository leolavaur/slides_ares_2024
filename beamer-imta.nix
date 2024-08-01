{ lib
, stdenv, fetchgit, writeShellScript
, texlive
, kpsewhich
}:

stdenv.mkDerivation rec {
  # Make this a valid tex(live-new) package;
  # the pkgs attribute is provided with a hack below.
  pname = "beamer-imta";
  version = "v1.0";
  tlType = "run";

  outputs = [ "tex" ];

  src = ./beamer;

  nativeBuildInputs = [
    (writeShellScript "force-tex-output.sh" ''
        out="''${tex-}"
      '')
    kpsewhich
  ];

  dontConfigure = true;

  installPhase = ''
    runHook preInstall

    path="$tex/tex/latex/${pname}"
    mkdir -p "$path"
    cp **/*.{cls,def,clo,sty} "$path/"

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://https://gitlab.com/latex-imt-atlantique/beamer-imt-atlantique";
    description = "IMT Atlantique theme for beamer";
    # license = licenses.lppl13c;
    platforms = platforms.all;
  };
}