
{ config, inputs, pkgs, ...}: {

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
        backend = "x";
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
      qiface.enable = true;
      ttecho.enable = true;
      root.enable = true;
    };
  };

  services.xserver = {
    enable = true;
    desktopManager = {
      cinnamon.enable = true;
      xterm.enable = false;
      session = [
        {
          name = "home-manager";
          start = ''
            ${pkgs.runtimeShell} $HOME/.hm-xsession &
            waitPID=$!
          '';
        }
        {
          name = "cinnamon";
          start = ''
            cinnamon
          '';
        }
      ];
    };
  };
}
