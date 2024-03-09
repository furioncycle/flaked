{config, lib, pkgs, ...}:
let
  cfg = config.host.application.vim;
in
  with lib;
{
  options = {
    host.application.vim = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable vim - thee greatest text editor";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vim
    ];
  };
}
