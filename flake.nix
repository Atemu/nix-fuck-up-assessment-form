{
  description = "A fuck-up flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        inherit (nixpkgs) lib;
        packages = self.packages.${system};
      in
      {
        packages = {
          form = pkgs.callPackage ./package.nix { inherit self; };

          default = self.packages.${system}.form;
        };
        apps = {
          default = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "open-fuckup-assessment" ''
                exec ${lib.getExe' pkgs.xdg-utils "xdg-open"} ${packages.default}
              ''
            );
          };
        };
      }
    );
}
