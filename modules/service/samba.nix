{ config, lib, pkgs, outputs, ... }:
let
  cfg = config.host.service.samba;
in
with lib;
{
  options = {
    host.service.samba = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable client samba";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.cifs-utils ];
    fileSystems."/mnt/share" = {
      device = "//VRChat/music";
      fsType = "cifs";
      options =
        let
          automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
        in
        [ "${automount_opts},credentials=/etc/nixos/smb-ids" ];
    };
  };
}
