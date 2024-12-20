{ config, lib, pkgs, ... }:
let
  cfg = config.host.feature.graphics.windowManager;
in
with lib;
{
  imports = [
    ./cage.nix
    ./openbox.nix
  ];

  options = {
    host.feature.graphics.windowManager = {
      manager = mkOption {
        type = types.enum [ "cage" "openbox" null ];
        default = null;
        description = "Window Manager to use";
      };
    };
  };
}
