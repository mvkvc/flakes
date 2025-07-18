{
  inputs = {
    nixpkgs.url     = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = with pkgs; mkShell {
          buildInputs = [
            ruby_3_4
            rubyPackages_3_4.ruby-lsp
            vips
            libyaml
            openssl
          ];

          shellHook = ''
            export BUNDLE_PATH=$PWD/.bundle
          '';
        };
      }
    );
}
