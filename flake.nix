{
  description = "Github pages website using Jekill";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      treefmt-nix,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      systems = lib.genAttrs lib.systems.doubles.all (any: any);
      eachSystem = lib.genAttrs [ systems.x86_64-linux ];
      eachSystemPkgs = f: eachSystem (system: f nixpkgs.legacyPackages.${system});
      
      # Formatting configuration and build
      treefmtConfig = {
        projectRootFile = "flake.nix";
        programs = {
          alejandra.enable = true;
          deadnix.enable = true;
          prettier.enable = true;
        };
      };
      treefmtBuild = eachSystemPkgs (pkgs: (treefmt-nix.lib.evalModule pkgs treefmtConfig).config.build);
    in
    {
      formatter = eachSystem (system: treefmtBuild.${system}.wrapper);
      checks = eachSystem (system: {
        formatting = treefmtBuild.${system}.check self;
      });
      packages = eachSystemPkgs (
        pkgs: 
        rec {
          lockGemset = pkgs.writeShellScriptBin "run" ''
            echo "Locking Gemfile..."
            ${pkgs.bundler}/bin/bundle config set path vendor
            ${pkgs.bundler}/bin/bundle config set --local force_ruby_platform true
            ${pkgs.bundler}/bin/bundle cache --no-install
            # ${pkgs.bundler}/bin/bundler lock
            echo "Locking Gemfile.lock to gemset.nix..."
            ${pkgs.bundix}/bin/bundix
            # ${pkgs.bundix}/bin/bundix -l
            rm -rf vendor
            rm -rf .bundle
          '';
          env = pkgs.bundlerEnv {
            name = "dvmcarpena.github.io";
            ruby = pkgs.ruby;
            gemfile = ./Gemfile;
            lockfile = ./Gemfile.lock;
            gemset = ./gemset.nix;
          };
          serveJekyll = pkgs.writeShellScriptBin "run" ''
            ${env}/bin/bundler exec -- jekyll serve --trace --livereload
            # exec ${env}/bin/jekyll serve --watch
          '';
        }
      );
      apps = eachSystem (
        system:
        rec {
          lock = {
            type = "app";
            program = "${self.packages.${system}.lockGemset}/bin/run";
          };
          serve = {
            type = "app";
            program = "${self.packages.${system}.serveJekyll}/bin/run";
          };
          default = serve;
        }
      );
      devShells = eachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            buildInputs = [
              self.packages.${system}.env
              pkgs.ruby
              pkgs.nodejs
              pkgs.git
            ];
          };
        }
      );
    };
}