{ config, lib, pkgs, ... }:

let
  cfg = config.host.feature.fonts;
  graphics = config.host.feature.graphics;
in
with lib;
{
  options = {
    host.feature.fonts = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable Fonts";
      };
    };
  };

  config = mkIf cfg.enable {
    fonts = mkIf graphics.enable {
      enableDefaultPackages = false;
      fontDir.enable = true;

      packages = with pkgs; [
        atkinson-hyperlegible-next
        atkinson-hyperlegible-mono
        noto-fonts-emoji
        noto-fonts-color-emoji
        noto-fonts-cjk-sans
        fira-code-symbols
      ];

      # user defined fonts
      fontconfig = mkIf graphics.enable {
        enable = mkDefault true;
        antialias = mkDefault true;
        cache32Bit = mkDefault true;
        hinting.enable = mkDefault true;
        hinting.autohint = mkDefault true;
        useEmbeddedBitmaps = mkDefault true;
      };
    };
  };
}
