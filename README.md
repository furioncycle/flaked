#  My NixOS Configurations

My "current" structure does not include my home manager configuration. If you are looking for that configuration head on over to my [Nix Home Manager | Dotfiles Repository](https://github.com/furioncycle/hogar).

**DO NOT USE THIS REPO for learning, it is opinionated and probably wrong**


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
  - `service`: Miscellanios  daemons
- `overlays`: Amendments and updates to packages that exist in the nix ecosphere
- `pkgs`: Custom packages, services, scripts that are specific to this installation
- `users`: Individual User folders

## Usage

Get your installer disc booted up and your disks partitioned.

- Generate your `hardware-configuration.nix` file.

```
nixos-generate-config --root /mnt --file /tmp
```

- Go ahead and clone this repository.

```
git clone https://github.com/furioncycle/flaked.git /mnt/etc/nixos
```

- Either create a new host entry in `flake.nix` and add associated bits to the `hosts` folder or modify one of the existing hosts `hardware-configuration.nix` with what you generated above. That's kinda janky, but it'll get you started..

- Install your new NixOS system


### Keep it up to date

```
sudo nix flake update /etc/nixos/
sudo nixos-rebuild switch --flake /etc/nixos/#<host>
```

Inspiration taken from [tiredofit](https://github.com/tiredofit) thank you!
