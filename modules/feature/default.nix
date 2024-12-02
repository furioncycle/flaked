{ lib, ... }:

with lib;
{
  imports = [
    ./boot
    ./graphics
    ./powermanagement
    ./virtualization
    ./cross_compilation.nix
    ./home_manager.nix
    ./fonts.nix
    ./security.nix
  ];
}
