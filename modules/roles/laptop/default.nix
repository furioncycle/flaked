{ config, lib, modulesPath, pkgs, ... }:
let
  role = config.host.role;
in
with lib;
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./power
  ];

  config = mkIf (role == "laptop" || role == "hybrid") {
    host = {
      feature = {
        # boot = {
        # efi.enable = mkDefault true;
        # graphical.enable = mkDefault true;
        # };
        fonts = {
          enable = mkDefault true;
        };
        graphics = {
          enable = mkDefault true; # We're working with a GUI here
          acceleration = mkDefault true; # Since we have a GUI, we want openGL
        };
        powermanagement = {
          enable = true;
          laptop = true;
        };
      };
      filesystem = {
        #   btrfs.enable = mkDefault true;
        #   encryption.enable = mkDefault true;
        #   impermanence.enable = mkDefault false;
        swap = {
          enable = mkDefault false;
          type = mkDefault "partition";
        };
      };
      hardware = {
        # android.enable = mkDefault true;
        backlight.enable = mkDefault true; # Most laptops have a backlight
        bluetooth.enable = mkDefault true; # Most wireless cards have bluetooth radios
        # printing.enable = mkDefault false; # If we don't have access to a physical printer we should be able to remotely print
        scanning.enable = mkDefault false;
        sound.enable = mkDefault true; #
        touchpad.enable = mkDefault true; # We want this most of the time
        webcam.enable = mkDefault false; # Age of video conferencing
        wireless.enable = mkDefault true; # Most systems have some sort of 802.11
        # yubikey.enable = mkDefault true;      #
      };
      network = {
        # firewall.fail2ban.enable = mkDefault false;
      };
      # service = {
      #   logrotate.enable = mkDefault true;
      #   ssh = {
      #     enable = mkDefault true;
      #     harden = mkDefault true;
      #   };
      # };
    };

    networking = {
      networkmanager = {
        enable = mkDefault true;
      };
    };
  };
}
