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
    # all fonts are linked to /nix/var/nix/profiles/system/sw/share/X11/fonts
    fonts = mkIf graphics.enable {
      # use fonts specified by user rather than default ones
      enableDefaultPackages = false;
      fontDir.enable = true;

      packages = with pkgs; [
        atkinson-hyperlegible
        atkinson-monolegible
      ];

      # user defined fonts
      fontconfig = mkIf graphics.enable {
        enable = mkDefault true;
        antialias = mkDefault true;
        cache32Bit = mkDefault true;
        hinting.enable = mkDefault true;
        hinting.autohint = mkDefault true;
        # defaultFonts = {
        # serif = [ "Noto Serif Nerd Font" "Noto Color Emoji" ];
        # sansSerif = [ "Noto Sans Nerd Font" "Noto Color Emoji" ];
        # monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
        # emoji = [ "Noto Color Emoji" ];
        # };
      };
    };
  };
}
