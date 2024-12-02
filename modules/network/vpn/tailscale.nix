{ config, lib, pkgs, ... }:

let
  cfg = config.host.network.vpn.tailscale;
in
with lib;
{
  options = {
    host.network.vpn.tailscale = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables Tailscale VPN functionality";
      };
    };
  };

  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = lib.mkDefault "client";
    };
    networking.firewall = {
      checkReversePath = "loose";
      allowedUDPPorts = [ 41641 ]; # Facilitate firewall punching
    };
  };
}
