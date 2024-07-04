{config, lib, ...}:
with lib;
{
  imports = [
    ./flatpak.nix
    ./virtd.nix
  ];
}
