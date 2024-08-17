{
  lib,
  stdenv,
  texliveSmall,
  inkscape,
  runCommand,
}:

stdenv.mkDerivation {
  name = "nix-fuckup-assessment-form.pdf";

  src = let
    # Only copy a select few files, not the entire tree that includes Nix code
    files = [ "Makefile" "form.tex" "nixos.svg" ];
    commands = map (file: "install ${./${file}} -D $out/${file}") files;
    script = lib.concatLines commands;
  in runCommand "source" { } script;

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
