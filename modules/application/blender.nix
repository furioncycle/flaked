{ config, lib, pkgs, ... }:
let
  cfg = config.host.application.blender;
in
with lib;
{
  options = {
    host.application.blender = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable blender";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      blender
      cura-appimage
    ];
  };
}
