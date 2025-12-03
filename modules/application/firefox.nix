{ config, lib, pkgs, ... }:

let
  cfg = config.host.application.firefox;
in
with lib;
{
  options = {
    host.application.firefox = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables firefox browser";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libreoffice
      firefox # TODO - remove
      librewolf # TODO - make default
    ];
  };
}
