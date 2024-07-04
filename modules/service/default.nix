{lib, ...}:

with lib;
{
  imports = [
    ./logrotate.nix
    ./ssh.nix
    ./syncthing.nix
    ./vscode_server.nix
  ];
}
