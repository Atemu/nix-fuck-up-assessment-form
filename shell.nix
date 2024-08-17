{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "nix-fuckup-shell";
  packages = with pkgs; [
    (texliveSmall.withPackages (p: [
      p.enumitem
      p.latexmk
      p.svg
      p.trimspaces
      p.transparent
    ]))
  ];
}
