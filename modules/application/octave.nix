{ config, lib, pkgs, ... }:
let
  cfg = config.host.application.octave;
in
with lib;
{
  options = {
    host.application.octave = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = "Enable GNU Octave";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.octaveFull
    ];
  };
}
