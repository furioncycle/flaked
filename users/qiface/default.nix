{ config, lib, pkgs, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
with lib;
{
  options = {
    host.user.qiface = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable qiface";
      };
    };
  };

  config = mkIf config.host.user.qiface.enable {
    users.users.qiface = {
      isNormalUser = true;
      shell = pkgs.bashInteractive;
      uid = 4200;
      group = "users";
      extraGroups = [
        "wheel"
        "video"
        "audio"
      ] ++ ifTheyExist [
        "input"
        "lp"
        "network"
      ];

      initialPassword = "1234";
    };
  };
}
