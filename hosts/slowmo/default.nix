{ config, inputs, pkgs, ... }: {

  imports = [
    inputs.nur.nixosModules.nur
    ./hardware-configuration.nix
    inputs.disko.nixosModules.disko
    ./disko-config.nix
    ../common
  ];

  boot = {
    kernelParams = [
      "quiet"
    ];
  };

  host = {
    application = {
      firefox = {
        enable = true;
      };
    };
    feature = {
      graphics = {
        enable = true;
        backend = "wayland";
        windowManager.manager = "sway";
        displayManager.manager = "sddm";
      };
    };
    filesystem = {
      swap = {
        partition = "disk/by-partlabel/swap";
      };
    };
    hardware = {
      cpu = "intel";
      gpu = "intel";
      sound = {
        server = "pulseaudio";
      };
    };
    network = {
      hostname = "slowmo";
    };
    role = "laptop";
    user = {
      ttecho.enable = true;
      root.enable = true;
    };
  };
}
