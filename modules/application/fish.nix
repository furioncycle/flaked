{config, lib, pkgs, ...}:
let
   cfg = config.host.application.fish;
in
   with lib;
{
  options = {
    host.application.fish = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable fish";
      };
    };
  };

  config = mkIf cfg.enable {
    programs = {
      fish.enable = true;
    };
  };
}
