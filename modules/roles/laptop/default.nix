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
        virtualization = {
          docker.enable = true;
        };
      };
      filesystem = {
        swap = {
          enable = mkDefault false;
          type = mkDefault "partition";
        };
      };
      hardware = {
        # android.enable = mkDefault true;
        backlight.enable = mkDefault true; # Most laptops have a backlight
        bluetooth.enable = mkDefault true; # Most wireless cards have bluetooth radios
        scanning.enable = mkDefault false;
        sound.enable = mkDefault true; #
        touchpad.enable = mkDefault true; # We want this most of the time
        webcam.enable = mkDefault false; # Age of video conferencing
        wireless.enable = mkDefault true; # Most systems have some sort of 802.11
        # yubikey.enable = mkDefault true;      #
      };
      network = { };

    };

    networking = {
      networkmanager = {
        enable = mkDefault true;
      };
    };
  };
}
