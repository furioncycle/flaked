{ lib, ... }:

with lib;
{
  imports = [
    ./bash.nix
    ./bind.nix
    ./blender.nix
    ./binutils.nix
    ./coreutils.nix
    ./curl.nix
    ./dust.nix
    ./e2fsprogs.nix
    ./fish.nix
    ./firefox.nix
    ./fzf.nix
    ./git.nix
    ./htop.nix
    ./iftop.nix
    ./inetutils.nix
    ./iotop.nix
    ./kitty.nix
    ./less.nix
    ./links.nix
    ./lsof.nix
    ./mtr.nix
    ./ncdu.nix
    ./pciutils.nix
    ./psmisc.nix
    ./rsync.nix
    ./strace.nix
    ./vim.nix
    ./wget.nix
  ];
}
