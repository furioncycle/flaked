{config, lib, pkgs, ...}:
let
  cfg = config.host.application.helix;
in
  with lib;
{
  options = {
    host.application.helix = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable helix";
      };
    };
  };

  config = mkIf cfg.enable {
    
  }
}
