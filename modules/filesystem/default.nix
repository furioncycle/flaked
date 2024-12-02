{ lib, ... }:

with lib;
{
  imports = [
    ./btrfs.nix
    ./exfat.nix
    ./ntfs.nix
    ./swap.nix
    ./tmp.nix
  ];
}
