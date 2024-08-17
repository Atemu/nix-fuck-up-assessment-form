{
  lib,
  stdenv,
  texliveSmall,
  inkscape,
  self ? null,
}:

stdenv.mkDerivation {
  name = "nix-fuckup-assessment-form.pdf";

  src = if self != null then self else builtins.fetchGit ./.;

  nativeBuildInputs = [
    (texliveSmall.withPackages (p: [
      p.enumitem
      p.latexmk
      p.svg
      p.trimspaces
      p.transparent
      p.catchfile
    ]))
    inkscape
  ];

  installPhase = ''
    runHook preInstall

    install form.pdf $out

    runHook postInstall
  '';

  meta = {
    description = "Nix fuckup assessment form";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.atemu ];
  };
}
