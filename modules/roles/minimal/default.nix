{ config, lib, modulesPath, pkgs, ... }:
let
  role = config.host.role;
in
with lib;
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  config = mkIf (role == "minimal") {
    host = {
      feature = {
        boot = {
          efi.enable = mkDefault false;
          graphical.enable = mkDefault false;
        };
        fonts = {
          enable = mkDefault false;
        };
        graphics = {
          enable = mkDefault false;
          acceleration = mkDefault true;
        };
      };
      filesystem = {
        btrfs.enable = mkDefault false;
        swap = {
          enable = mkDefault false;
        };
      };
      hardware = {
        bluetooth.enable = mkDefault false;
        printing.enable = mkDefault false;
        scanning.enable = mkDefault false;
        sound.enable = mkDefault false;
        webcam.enable = mkDefault false;
        wireless.enable = mkDefault false;
        yubikey.enable = mkDefault false;
      };
      network = {
        firewall.fail2ban.enable = mkDefault false;
      };
      service = {
        logrotate.enable = mkDefault false;
        ssh = {
          enable = mkDefault true;
        };
      };
    };
  };
}
