{
  inputs = {
    nixpkgs.url     = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShells.default = with pkgs; mkShell {
          buildInputs = [
            beam.packages.erlang_27.elixir_1_18 
          ];
          shellHook = ''
            export HEX_HOME="$PWD/.hex"
            export MIX_HOME="$PWD/.mix"
            export PATH="$HEX_HOME/bin:$PATH"
            export PATH="$MIX_HOME/bin:$PATH"
            export PATH="$MIX_HOME/escripts:$PATH"
            export LOCALE_ARCHIVE="${pkgs.glibcLocales}/lib/locale/locale-archive"
          '';
        };
      }
    );
}
