{ config, lib, pkgs, ... }:

let
  cfg = config.host.hardware.bluetooth;
in
with lib;
{
  options = {
    host.hardware.bluetooth = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable Bluetooth";
      };
    };
  };

  config = mkIf cfg.enable {
    boot.kernelParams = [ "btusb" ];
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      disabledPlugins = [ "sap" ];
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          # JustWorksRepairing = "always";
          # MultiProfile = "multiple";
        };
      };
    };

    services.blueman.enable = true;

  };
}
