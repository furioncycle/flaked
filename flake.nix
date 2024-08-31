{
  description = "Stolen flake ----";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://nix-gaming.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
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

          cell = lib.nixosSystem {
            modules = [ ./hosts/cell ];
            specialArgs = { inherit inputs outputs; };
          };
        };

        templates = {
          dafny = {
            description = ''
              Everything needed to run dafny
            '';
            path = ./templates/dafny;
          };
          ada = {
            description = ''
              Everything needed to run ada
            '';
            path = ./templates/dafny;
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
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    impermanence.url = "github:nix-community/impermanence";
    nur.url = "github:nix-community/NUR";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    nix-gaming.url = "github:fufexan/nix-gaming";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };
}
