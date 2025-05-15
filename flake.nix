{
  description = "Flake that provides GitHub Linguist via bundlerEnv";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      eachSystem = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
    packages = eachSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        ruby = pkgs.ruby_3_1;

        linguist = pkgs.bundlerEnv {
          name = "linguist";
          ruby = ruby;
          gemdir = ./.;
        };
      in {
        default = linguist;
      }
    );
    devShells = eachSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        ruby = pkgs.ruby_3_1;

        linguist = pkgs.bundlerEnv {
          name = "linguist";
          ruby = ruby;
          gemdir = ./.;
        };
      in {
        default = pkgs.mkShell {
          buildInputs = [ linguist pkgs.jq ];
          shellHook = ''
            export GEM_HOME=${linguist}/lib/ruby/gems/${ruby.version}
            export PATH=${linguist}/bin:$PATH
          '';
        };
      }
    );
    in
		{inherit packages devShells;};
}

