{
  description = " Slides for my presentation at ARES 2024";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system: 
    let
      pkgs = import nixpkgs { inherit system; };
    in {
    devShells.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        texliveFull
        # (texliveFull.withPackages (_: [
        #   self.packages.${system}.beamer-imta
        # ]))
      ];

    };

    # packages.beamer-imta = pkgs.callPackage ./beamer-imta.nix {};
  });

}