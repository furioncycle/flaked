{ inputs, modulesPath, pkgs, ...}: {

  imports = [
    inputs.disko.nixosModules.disko
    ../../templates/disko/efi-btrfs-impermanence-swap.nix
    ../../templates/machine/virtd-vm.nix
    inputs.nur.nixosModules.nur

    ../common
  ];

  host = {
    feature = {
      graphics = {
        enable = false;
      };
    };
    filesystem = {
      btrfs.enable = true;
      encryption.enable = false;
      impermanence.enable = true;
    };
    hardware = {
      cpu = "vm-amd";
      # raid.enable = true; TODO - raid maybe
      sound = {
        enable = false;
        server = "pulseaudio";
      };
    };
    network = {
      hostname = "disko";
      type = "dynamic";
    };
    role = "vm";
    user = {
      ttecho.enable = true;
      root.enable = true;
    };
  };
}
