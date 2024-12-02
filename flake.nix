{
  description = "Stolen flake ----";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-substituters = [
    ];
    extra-trusted-public-keys = [
    ];
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSystem = f: lib.genAttrs systems (sys: f pkgsFor.${sys});
      pkgsFor = lib.genAttrs systems (system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });

    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = {

        inherit lib;
        nixosModules = import ./modules;
        overlays = import ./overlays { inherit inputs outputs; };
        packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
        devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
        formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

        nixosConfigurations = {

          slowmo = lib.nixosSystem {
            modules = [ ./hosts/slowmo ];
            specialArgs = { inherit inputs outputs; };
          };

          deaf = lib.nixosSystem {
            modules = [ ./hosts/deaf ];
            specialArgs = { inherit inputs outputs; };
          };
        };

        templates = {
          dafny = {
            description = ''
              Everything needed to run dafny

              TODO - enable ide and compiler
            '';
            path = ./templates/dafny;
          };
          ada = {
            description = ''
              Everything needed to run ada

              TODO - enable alr 
            '';
            path = ./templates/ada;
          };
        };
      };
      systems = [
        "x86_64-linux"
      ];
      perSystem = { config, ... }: { };

    };

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    vscode-server.url = "github:nix-community/nixos-vscode-server";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };
}
