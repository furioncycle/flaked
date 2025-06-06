{ config, lib, pkgs, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
with lib;
{
  options = {
    host.user.ttecho = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable Ttecho";
      };
    };
  };

  config = mkIf config.host.user.ttecho.enable {
    users.users.ttecho = {
      isNormalUser = true;
      shell = pkgs.fish;
      uid = 6969;
      extraGroups = [
        "wheel"
        "video"
        "audio"
      ] ++ ifTheyExist [
        "git"
        "input"
        "libvirtd"
        "lp"
        "network"
      ];

      initialPassword = "1234";
    };
  };
}
