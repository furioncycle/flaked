{ lib, ... }:

with lib;
{
  imports = [
    ./firewall
    ./blocker.nix
    ./domainname.nix
    ./hostname.nix
    ./vpn
    ./wired.nix
  ];
}
