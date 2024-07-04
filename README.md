#  NixOS Configurations

Here are my [NixOS](https://nixos.org/) configurations.

These allows for system portability and configuration from machine to machine with a small amount of changes (usually disks, partitions, or hardware changes) once and enjoy a many times forward. The configurations allow for a base system to be installed, with a core amount of applications to operate. They shine when you add something like [Home Manager](https://nix-community.github.io/home-manager/) is installed to allow for discrete per-user configuration of the environment. If you are looking for that configuration head on over to my [Nix Home Manager | Dotfiles Repository](https://github.com/furioncycle/hogar).

**DO NOT USE THIS REPO**

## Tree Structure

- `flake.nix`: Entrypoint for NixOS configurations.
- `hosts`: Host Configurations
  - `common`: Shared configurations consumed by all hosts.
  - `<host_a>`: "host_a" specific hardware and host configuration
  - `...`: And so on as above with other hosts
- `lib`: Helpers, functions, libraries and timesavers
- `modules`: Modules that are specific to this implementation and allow for toggled configuration
  - `application`: Applications accessible to all users of system
  - `container`: Containers using some sort of OCI container engine
  - `features`: Features such as virtualization, gaming, cross compilation
  - `filesystem`: Encryption, impermanence, BTRFS options
  - `hardware`: Bluetooth, Printing, Sound, Wireless
  - `network`: Firewalls and VPNs
  - `service`: Miscellanious daemons
- `overlays`: Ammendments and updates to packages that exist in the nix ecosphere
- `pkgs`: Custom packages, services, scripts that are specific to this installation
- `users`: Individual User folders

## Usage

### Manual approach

Get your installer disc booted up and your disks partitioned.

- Generate your `hardware-configuration.nix` file.

```
nixos-generate-config --root /mnt --file /tmp
```

- Go ahead and clone this repository.

```
nix-shell -p git nixFlakes
git clone https://github.com/furioncycle/flaked.git /mnt/etc/nixos
```

- Either create a new host entry in `flake.nix` and add associated bits to the `hosts` folder or modify one of the existing hosts `hardware-configuration.nix` with what you generated above. That's kinda janky, but it'll get you started..

- Install your new NixOS system

```
nixos-install --root /mnt --flake /mnt/etc/nixos#<host>
```
### Configuring a system

Features are toggleable via the `host` configuration options. Have a look insie the `modules/nixos` folder for options available.

For example to have a base AMD system using with an integrated GPU using BTRFS as a file system that allowed SSH, Docker, and a hardware webcam it would be configured as such:

```
  host = {
    hardware = {
      cpu = "amd";
      graphics = {
        acceleration = true;
        displayServer = "x";
        gpu = "integrated-amd";
      };
      webcam.enable = true;
    };
    network = {
      hostname = "samplehostname" ;
      domainname = "tiredofit.ca" ;
    };
    role = server;
  };
```

This very much relies on the `modules/roles` folder and sets defaults per role, which can be overridden in each hosts unique configuration.

### Keep it up to date

```
sudo nix flake update /etc/nixos/
sudo nixos-rebuild switch --flake /etc/nixos/#<host>
```

### Managing Secrets

TODO - implement again

# License

Do you what you'd like and I hope that this inspires you for your own configurations as many others have myself.
