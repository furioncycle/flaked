# Shell for bootstrapping flake-enabled nix and other tooling
{ pkgs ? # If pkgs is not defined, instanciate nixpkgs from locked commit
  let
    lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
    nixpkgs = fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
      sha256 = lock.narHash;
    };
  in
  import nixpkgs { overlays = [ ]; }
, ...
}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes ";
    nativeBuildInputs = with pkgs; [
      age
      git
      gnupg
      home-manager
      nix
      sops
      ssh-to-age
    ];
  };
  # ada = pkgs.mkShell {
  #   buildInputs = with pkgs; [
  #     alire
  #   ];
  # };
  alloy = pkgs.mkShell {
    buildInputs = with pkgs; [
      alloy6
    ];
  };
  forge = pkgs.mkShell {
    buildInputs = with pkgs; [
      racket
      jdk
    ];
    nativeBuildInputs = [ pkgs.makeWrapper ];

    shellHook = ''
      raco pkg install --auto forge froglet
    '';
  };
  tla = pkgs.mkShell {
    buildInputs = with pkgs; [
      tlaplusToolbox
    ];
  };
  uiua = pkgs.mkShell {
    buildInputs = with pkgs; [
      uiua
    ];
  };


}
