{ config, lib, pkgs, ... }:
let
  cfg = config.host.feature.virtualization.docker;
in
with lib;
with pkgs;
{
  options = {
    host.feature.virtualization.docker = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable docker";
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
    };
  };
}
