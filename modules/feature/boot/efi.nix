{ config, lib, pkgs, ... }:

let
  cfg = config.host.feature.boot;
in
with lib;
{
  options = {
    host.feature.boot = {
      efi = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables booting via EFI";
        };
      };
      loader = mkOption {
        default = "grub";
        type = types.enum [ "grub" ];
        description = "Enables booting via Grub";
      };
    };
  };

  config = mkIf cfg.efi.enable {
    boot = {
      loader = {
        efi = {
          canTouchEfiVariables = false;
        };
        grub = mkIf (cfg.loader == "grub") {
          enable = mkDefault true;
          device = "nodev";
          efiSupport = cfg.efi.enable;
          enableCryptodisk = mkDefault false;
          useOSProber = mkDefault false;
          efiInstallAsRemovable = true;
        };
      };
    };
  };
}
