{ config, inputs, pkgs, ... }: {

  imports = [
    inputs.nur.modules.nixos.default
    ./configuration.nix
    # inputs.disko.nixosModules.disko
    # ./disko-config.nix
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
      blender.enable = true;
      octave.enable = true;
    };
    feature = {
      graphics = {
        enable = true;
        backend = "x";

      };
      development.crosscompilation = {
        enable = false;
      };
    };
    filesystem = {
      swap = {
        partition = "disk/by-uuid/ca380f70-e44b-4b9a-ab6f-4a9c6620fedc";
      };
    };
    hardware = {
      cpu = "intel";
      gpu = "intel";
      sound = {
        server = "pipewire";
      };
    };
    network = {
      hostname = "deaf";
    };
    role = "laptop";
    user = {
      # qiface.enable = true;
      ttecho.enable = true;
      root.enable = true;
    };
    service.samba.enable = true;
  };

  services.xserver = {
    enable = true;
    desktopManager = {
      cinnamon.enable = false;
      pantheon.enable = true;
      xterm.enable = false;
      session = [
        {
          name = "home-manager";
          start = ''
            ${pkgs.runtimeShell} $HOME/.hm-xsession &
            waitPID=$!
          '';
        }
        # {
        #   name = "cinnamon";
        #   start = ''
        #     cinnamon
        #   '';
        # }
      ];
    };
  };
}
